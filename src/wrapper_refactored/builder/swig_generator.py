# -*- coding: iso-8859-1 -*-
#! /usr/bin/python

##Copyright 2008-2009 Thomas Paviot (tpaviot@gmail.com)
##
##This file is part of pythonOCC.
##
##pythonOCC is free software: you can redistribute it and/or modify
##it under the terms of the GNU General Public License as published by
##the Free Software Foundation, either version 3 of the License, or
##(at your option) any later version.
##
##pythonOCC is distributed in the hope that it will be useful,
##but WITHOUT ANY WARRANTY; without even the implied warranty of
##MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##GNU General Public License for more details.
##
##You should have received a copy of the GNU General Public License
##along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.

from itertools import chain, islice
from pygccxml.declarations.matchers import access_type_matcher_t, matcher_base_t
from pyplusplus import module_builder
from templates import ClassTemplate, FunctionTemplate, GUIDTemplate, \
    HashTemplate, TopoShapePickleTemplate, SMDSMeshIterator, XCAFAppTemplate, \
    GeomDestructorTemplate, GetHandleTemplate, GetObjectTemplate, OStreamTemplate, \
    IStreamTemplate, DependencyTemplate, WrapperTemplate, EnumTemplate, \
    ModuleTemplate, PropertyTemplate
import configuration

import environment
import glob
import os
import os.path
import re
import sys
#import occ_module_builder
#from occ_declarations import namespace_t
import pygccxml
import time
#import server

from pyplusplus.module_builder.boost_python_builder import builder_t
#from db_import import Exporter
import networkx
#from configuration import gccxml_header_filter
from pygccxml import declarations
from templates import TypeDefTemplate
#from pyplusplus.decl_wrappers.namespace_wrapper import namespace_t

import pypp_mods
from pyplusplus.decl_wrappers.class_wrapper import class_t
from pypp_mods import module_list
from builder.pypp_mods import handle_matcher, include_matcher



        

def CaseSensitiveGlob(wildcard):
    """
    Case sensitive glob for Windows.
    Designed for handling of GEOM and Geom modules
    This function makes the difference between GEOM_* and Geom_* under Windows
    """
    flist = glob.glob(wildcard)
    pattern = wildcard.split('*')[0]
    f = []
    for file in flist:
        if pattern in file:
            f.append(file)
    return f
   
      
    
class ModularBuilder(object):
    """
    This class generates a set of .i files integrated in one OCC.i script. The result is
    a simple _OCC.pyd and OCC.py script that enable better handliing of different OCC classes.
    """
    #def __init__( self , module, generate_doc = False, include_path = environment.OCC_INC):
    def __init__( self , module_names, config=None, rebuild_db=False):
        self.module_names = module_names
        self.rebuild_db = rebuild_db

        self.include_path = environment.OCC_INC #the path where are the headers to parse can be OCC_INC or SALOME_GEOM_INC
        self.wrappers = {}
        
        self.build_path = os.path.join(os.getcwd(),"SWIG","linux_darwin")
        self.cache_file = os.path.join(self.build_path, "SWIG", "pyppp_cache.pkl")
        
        self.write_wrapper()
        print self.module_names
        if len(self.module_names) < 1:
            print "no modules to import"
            return
        self.build_modules()
        self.configure_modules()
        self.set_dependencies()
        self.write_modules()
        
    def get_headers_for_module(self, module, headers):
        exp = re.compile("^((?:Handle_)*%s(?:_\w+)*\.hxx)" % module)
        heads = map(lambda h: exp.findall(h), os.listdir(self.include_path))
        heads = filter(lambda h: bool(h), heads)
        heads =  map(lambda h: os.path.join(self.include_path, h[0]), heads)
        heads.sort()
        #print heads
        additional = []
        for additional_header in configuration.modules[module].get('include', []):
            #additional += CaseSensitiveGlob(os.path.join(self.INC_PATH,'%s*.hxx'%additional_header))
            additional += CaseSensitiveGlob(os.path.join(self.include_path,'%s*.hxx'%additional_header))
        
        additional = filter(lambda h: h not in heads, additional)
        #headers = filter(gccxml_header_filter, )
        
        return sorted(additional + heads)
           
    def get_dependant_modules(self, modules, modules_to_read=None):
        headers = set([])
        if modules_to_read is None:
            modules_to_read = set([])
        
        for module in modules:
            if module in modules_to_read:
                continue
            headers = headers.union(self.get_headers_for_module(module))
            modules_to_read.add(module)

        deps = set([])
        
        for head in headers:
            try:
                f = file(head, 'r')
                d = re.findall("#include \<(?:Handle_)*([A-Za-z0-9]+?)(?:_\w+)*\.hxx\>", f.read())
                f.close()
                for mod in d:
                    deps.add(mod)
            except IOError:
                pass
        
        new_deps = deps.difference(modules_to_read)
        #print "end", new_deps, headers, modules_to_read
        if len(new_deps) == 0:
            return modules_to_read
        return self.get_dependant_modules(new_deps, modules_to_read)
        
    
    
    def write_wrapper(self):
        
        #headers = []
        #for module_name in self.module_names:
        #    headers += CaseSensitiveGlob(os.path.join(self.include_path,'%s_*.hxx'%module_name))
        #    headers += CaseSensitiveGlob(os.path.join(self.include_path,'%s.hxx'%module_name))
        #    headers += CaseSensitiveGlob(os.path.join(self.include_path,'Handle_%s_*.hxx'%module_name))
        
        #headers = self.get_dependent_headers(headers)
        
        #self.module_names =  self.get_dependant_modules(self.module_names)
        
        modules = []
        dep_graph = configuration.module_dependencies
        for module in self.module_names:
            if not dep_graph.has_node(module):
                continue
            for dep in networkx.dfs_postorder(dep_graph, module):
                if dep not in modules:
                    print "adddep", dep
                    modules.append(dep)
            if module not in modules:
                modules.append(module)
        self.module_names = modules
        #only include modules in original list
        self.module_names = filter(lambda m: m in configuration.modules, self.module_names)
        self.module_names = filter(lambda m: m not in configuration.excluded_module_deps, self.module_names)
        print "before db", self.module_names
        
        def module_in_db(name):
            from server.source import models
            try:
                module = models.Module.objects.get(name=name)
                return module.is_complete
            except models.Module.DoesNotExist:
                return False
        
        #us db as cache
        if not self.rebuild_db:
            self.cached_modules = filter(module_in_db, self.module_names)
            self.module_names = filter(lambda m: m not in self.cached_modules, self.module_names)
        else: 
            self.cached_modules = []
        print "not in db",self.module_names
        
        headers = []
        for m in self.module_names:
            for h in self.get_headers_for_module(m, headers):
                if h not in headers:
                    headers.append(h)
        

        
        #print "h", headers              
        self.headers = filter(configuration.gccxml_header_filter, headers)
        #print "h", self.headers
        wrapper_template = WrapperTemplate()
        t = int(time.time())
        print self.build_path
        filename = os.path.join(self.build_path,'WrapperHeaders.hxx')
        with file(filename, 'w') as wrapper_file:
            wrapper_file.write(wrapper_template.render(("wrapper_%s" % t, self.headers)))
            self.wrapper_file = filename               
        


    def get_documentation(self, m, lines):
        doc = []

        for l in reversed(lines[0:m.location.line-1]):
            if l.startswith("//!"):
                doc.append(re.sub("\/\/\!", "", l).strip())
            elif l.startswith("//") or l.strip() == '':
                continue  
            else:
                break      
        
        return "\n".join(reversed(doc))
        
    
    
    def build_modules(self):
        paths = [self.include_path, 
                 "%s/SWIG/linux_darwin" % os.getcwd(),
                 "%s/../contrib" % os.getcwd(),
                 #environment.SWIG_FILES_PATH_MODULAR, 
                 environment.OCC_INC,
                 #environment.BOOST_INC
                 ]
        
        #print environment.BOOST_INC
        #print paths
        print "module builder"
        #self._mb = occ_module_builder.builder_t(
        self._mb = module_builder.module_builder_t(
                files=[self.wrapper_file],
                gccxml_path=environment.GCC_XML_PATH,
                define_symbols=environment.PYGCCXML_DEFINES,
                include_paths=paths,
                #cache=file_cache_t(self.cache_file)
                )
        mb = self._mb
        
        
        
        self.modules = module_list(self.module_names, mb.global_ns)
        
        ######################
        # Trim declarations  #
        ######################
        
        # Remove unused classes
#        for underscored in mb.classes(lambda c: c.name.startswith("_"), recursive=False):
#            mb.global_ns.remove_declaration(underscored)
        for rem in mb.namespaces(recursive=False):
            mb.global_ns.remove_declaration(rem)
        
        
        print self.module_names
        
        
        
        # Create modules
        
        
        
        
        # create namespace for each module in pygccxml
#        for module_name in self.module_names + self.cached_modules:
#            try:
#                ns = namespace_t(module_name)
#            except declarations.matcher.declaration_not_found_t: 
#                continue
#            for c in mb.classes(module_matcher(module_name), recursive=False):
#                ns.adopt_declaration(c)
#                mb.global_ns.remove_declaration(c)
#                
#                # pypp removes the prefix when adopting the declaration
#            
#                for decl in ns.decls(lambda d: d.name == '' or d.name[0] == '_'):
#                    decl.rename(module_name+decl.name)
#                    #decl._name = module_name+decl.name
#            
#            mb.global_ns.adopt_declaration(ns)
#        print "Sentry", mb.class_("Sentry"), mb.class_("Sentry").name
#        
        #print "Sentry", mb.namespace("Standard").class_("Sentry")
        
        
        
        #remove all that have not been moved to a namespace
        for rem in mb.classes(lambda d: d.prefix() not in self.module_names, recursive=False):
            mb.global_ns.remove_declaration(rem)
        for rem in mb.global_ns.typedefs(lambda d: d.prefix() not in self.module_names, recursive=False):
            mb.global_ns.remove_declaration(rem)
        for rem in mb.global_ns.enums(lambda d: d.prefix() not in self.module_names, recursive=False):
            mb.global_ns.remove_declaration(rem)
        
        
        for rem in mb.classes(lambda decl: isinstance(decl.parent, class_t)):
            print rem.name
            rem.parent.remove_declaration(rem)
        
#        for calldef in mb.calldefs():
#            calldef.args().parent = calldef
        print "Sentry", mb.class_("Sentry")
        #print "Sentry", mb.namespace("Standard").class_("Sentry")
        
        #ignore 
        
        
        
        mb.run_query_optimizer()
        #print "Sentry", mb.namespace("Standard").class_("Sentry")
        
        #create occ module containers
        #self.modules = [occ_module_t(name, mb.global_ns) for name in self.module_names]
        
        
        #################
        # Documentation #
        #################
        
        for cls in mb.classes():
            if cls.location.file_name == '<built-in>':
                continue
            
            lines = file(cls.location.file_name, 'r').readlines()
            decls = [cls] + list(cls.decls())
            for decl in decls:
                decl.documentation = self.get_documentation(decl, lines)
        
        #####################
        # DEFAULT TEMPLATES #
        #####################
                
#        modules = mb.namespaces()
#        modules.main_template = ModuleTemplate()
#        modules.license_template = LicenseTemplate()
        mb.classes().main_template = ClassTemplate()
        mb.mem_funs().main_template = FunctionTemplate()
        mb.operators().main_template = FunctionTemplate()
        mb.constructors().main_template = FunctionTemplate()
        mb.variables().main_template = PropertyTemplate()
        mb.enumerations().main_template = EnumTemplate()
        mb.global_ns.typedefs().main_template = TypeDefTemplate()
        
        ###################
        # DEFAULT IGNORES #
        ###################
        mb.decls().include()
        mb.decls(lambda f: f.parent.ignore).exclude()       
        mb.decls(access_type_matcher_t('private')).exclude()
        mb.decls(access_type_matcher_t('protected')).exclude()
#        mb.operators(lambda o: 'operator ' in o.name).exclude()
#        mb.operators('operator->').exclude()
#        mb.operators('operator<<').exclude()
#        mb.operators('operator*').exclude()
        #mb.calldefs("DynamicType").exclude()
        
    
    
    def configure_modules(self):
        mb = self._mb
        handles = mb.classes(lambda c: c.name.startswith("Handle_"))
        handles.is_handle = True
        ###########
        # IGNORES #
        ###########
        
        #exclude classes and methods from confguration.yml
        
        mb.classes(lambda c: c.prefix() and c.name in configuration.modules[c.prefix()].get('exclude', [])).exclude()
        
        for module_name in self.module_names:
            module_conf = configuration.modules[module_name]
            for cls, excludes in module_conf.get('exclude_members', {}).items():
                mb.classes(cls).mem_funs(lambda f: f in excludes).exclude()



        
        
        #####################
        # CUSTOMIZE MODULES #
        #####################

        
        mb.namespaces(lambda n: n.name in ['SMDS','SMESH','StdMeshers']).require_template_lib = True
        self.modules.get(['SMDS','SMESH','StdMeshers']).require_template_lib = True
        
        
        #mb.namespaces('GEOMAlgo').classes().no_destructor = True
        self.modules.get('GEOMAlgo').classes().no_destructor = True
        #mb.namespaces(lambda n: not n.name.startswith('GEOMAlgo')).classes().add_template(GeomDestructorTemplate())
        self.modules.get(lambda n: not n.name.startswith('GEOMAlgo')).classes().add_template(GeomDestructorTemplate())
        
        ####################
        # CUSTOM TEMPLATES #
        ####################
        
        mb.classes(handle_matcher).add_template(GetObjectTemplate())
        object_with_handle = lambda a: not a.is_handle and len(mb.classes("Handle_%s"%a.name))
        mb.classes(object_with_handle).add_template(GetHandleTemplate())
        
        mb.mem_funs(arg_types=['Standard_OStream &']).main_template = OStreamTemplate()
        mb.mem_funs(arg_types=['std::istream &']).main_template = IStreamTemplate()
        
        mb.classes('Standard_GUID').add_template(GUIDTemplate())
        
        
        def inherits_HashCode(cls):
            classes = [cls] + [h.related_class for h in cls.recursive_bases]
            for c in classes:
                if "HashCode" in c.mem_funs().name:
                    return True
            
        
        mb.classes(inherits_HashCode).add_template(HashTemplate())
        
        mb.classes('SMDS_Mesh').add_template(SMDSMeshIterator())
        mb.classes('TopoDS_Shape').add_template(TopoShapePickleTemplate())
        mb.classes('XCAFApp_Application').add_template(XCAFAppTemplate())
        
        
        ######################
        # ARGUMENT REWRITING #
        ######################
        
        calldefs = mb.calldefs(include_matcher)
        calldefs.args('std::vector<int').type = 'std::vector<int>'
        calldefs.args('std::vector<double').type = 'std::vector<double>'
        calldefs.args('std::vector<int').type = 'std::vector<int>'
        calldefs.args('std::vector<int').type = 'std::list<std::string>'
        calldefs.args('Standard_CString const').type = 'char const *'
        
        calldefs.args(['Standard_Real &' ,
                       'Quantity_Parameter &', 
                       'Quantity_Length &', 
                       'V3d_Coordinate &']).type = "Standard_Real &"
        
        calldefs.args(['Standard_Real &',
                       'Standard_Integer &', 
                      'FairCurve_AnalysisCode &']).name = "OutValue"
                       
                       
                       
        funs = mb.mem_funs(lambda f: f.name in ['D0','D1', 'D2','D3'], return_type='void')
        funs.args(['gp_Pnt &', 'gp_Vec &']).name = "OutValue"
        
        calldefs.args('=1u').default_value = '1'
        calldefs.args('=0u').default_value = '0'

        #########################
        # RETURN TYPE REWRITING #
        #########################
        #TODO fix query stuff
        mb.calldefs(return_type="::Standard_CString const").return_type = 'char const *'
        mb.calldefs(return_type="Standard_CString").return_type = 'char *'
    
        #pyplusplus automatically creates an assign alias, reset that for comparison
        #mb.calldefs("operator=").rename("operator=")
                                   
    def set_dependencies(self):
        for module in self._mb.namespaces():
            #sources
            print  len(module.calldefs())
            types = module.calldefs().return_type.to_list()
            types.extend(module.calldefs().args().type.to_list())
            types.extend(module.variables().type.to_list())
            bases = module.classes(lambda c: hasattr(c, 'bases')).bases
            bases = filter(lambda b: bool(b), bases)
            types.extend([b[0].related_class.name for b in bases])
            
            #filter
            
            types = [re.sub("&|\*|(const)", "", str(t)).strip() for t in types]
            types = filter(lambda t: t == ['', None], types)
            #types = [re.findall("^(?:const)*\**\&*(\w+)", str(t))[0] for t in types]
            tt = []
            for t in types:
                t = str(t)
                print t, " ==== ", re.findall("^(?:const)*\**\&*(\w+)", t)[0]
                tt.append(re.findall("^(?:const)*\**\&*(\w+)", t)[0]) 
                
            #print types
            types = list(set(types))
            
            #types = filter(lambda t: not re.search(exclude_exp, t), types)
            #types = filter(lambda t: not in , t), types)            
            types = filter(configuration.dependency_filter, types)
            

            #assign
            types.sort()
            module.include_files.extend(types)
    

    def write_modules(self):
        dep_template = DependencyTemplate()
        
        for module_name in self.module_names:
            #module = self._mb.namespace(module_name)
            
            #write module
            module_file = file(os.path.join(self.build_path, "%s.i"%module_name), 'w')
            module_file.write(ModuleTemplate().render([module_name, self._mb.global_ns]))
            module_file.close()
            
            #write dependencies
#            dep_file = file(os.path.join(self.build_path, "%s_dependencies.i"%module_name), 'w')
#            dep_file.write(dep_template.render(module))
#            dep_file.close()



    
    
