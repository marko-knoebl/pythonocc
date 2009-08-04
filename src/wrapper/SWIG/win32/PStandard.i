/*

Copyright 2008-2009 Thomas Paviot (tpaviot@gmail.com)

This file is part of pythonOCC.

pythonOCC is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pythonOCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.

*/
%module PStandard

%include PStandard_renames.i

%include typemaps.i
%include cmalloc.i
%include cpointer.i
%include carrays.i
%include exception.i
%include std_list.i
%include std_string.i
%include <python/std_basic_string.i>

#ifndef _Standard_TypeDef_HeaderFile
#define _Standard_TypeDef_HeaderFile
#define Standard_False (Standard_Boolean) 0
#define Standard_True  (Standard_Boolean) 1
#endif

/*
Exception handling
*/
%{#include <Standard_Failure.hxx>%}
%exception
{
    try
    {
        $action
    } 
    catch(Standard_Failure)
    {
        SWIG_exception(SWIG_RuntimeError,Standard_Failure::Caught()->DynamicType()->Name());
    }
}

/*
Standard_Real & function transformation
*/
%typemap(argout) Standard_Real &OutValue {
    PyObject *o, *o2, *o3;
    o = PyFloat_FromDouble(*$1);
    if ((!$result) || ($result == Py_None)) {
        $result = o;
    } else {
        if (!PyTuple_Check($result)) {
            PyObject *o2 = $result;
            $result = PyTuple_New(1);
            PyTuple_SetItem($result,0,o2);
        }
        o3 = PyTuple_New(1);
        PyTuple_SetItem(o3,0,o);
        o2 = $result;
        $result = PySequence_Concat(o2,o3);
        Py_DECREF(o2);
        Py_DECREF(o3);
    }
}

%typemap(in,numinputs=0) Standard_Real &OutValue(Standard_Real temp) {
    $1 = &temp;
}

/*
Standard_Integer & function transformation
*/
%typemap(argout) Standard_Integer &OutValue {
    PyObject *o, *o2, *o3;
    o = PyInt_FromLong(*$1);
    if ((!$result) || ($result == Py_None)) {
        $result = o;
    } else {
        if (!PyTuple_Check($result)) {
            PyObject *o2 = $result;
            $result = PyTuple_New(1);
            PyTuple_SetItem($result,0,o2);
        }
        o3 = PyTuple_New(1);
        PyTuple_SetItem(o3,0,o);
        o2 = $result;
        $result = PySequence_Concat(o2,o3);
        Py_DECREF(o2);
        Py_DECREF(o3);
    }
}

%typemap(in,numinputs=0) Standard_Integer &OutValue(Standard_Integer temp) {
    $1 = &temp;
}

/*
Renaming operator = that can't be wrapped in Python
*/
%rename(Set) *::operator=;


%include PStandard_dependencies.i


%include PStandard_headers.i




%nodefaultctor Handle_PStandard_ArrayNode;
class Handle_PStandard_ArrayNode : public Handle_Standard_Persistent {
	public:
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode();
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode(const Handle_PStandard_ArrayNode &aHandle);
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode(const PStandard_ArrayNode *anItem);
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode & operator=(const Handle_PStandard_ArrayNode &aHandle);
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode & operator=(const PStandard_ArrayNode *anItem);
		%feature("autodoc", "1");
		Handle_PStandard_ArrayNode const DownCast(const Handle_Standard_Persistent &AnObject);

};
%extend Handle_PStandard_ArrayNode {
	PStandard_ArrayNode* GetObject() {
	return (PStandard_ArrayNode*)$self->Access();
	}
};
%extend Handle_PStandard_ArrayNode {
	~Handle_PStandard_ArrayNode() {
	char *__env=getenv("PYTHONOCC_VERBOSE");
	if (__env){printf("## Call custom destructor for instance of Handle_PStandard_ArrayNode\n");}
	}
};


%nodefaultctor PStandard_ArrayNode;
class PStandard_ArrayNode : public Standard_Persistent {
	public:
		%feature("autodoc", "1");
		PStandard_ArrayNode();
		%feature("autodoc", "1");
		PStandard_ArrayNode(const Storage_stCONSTclCOM &a);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;

};
%extend PStandard_ArrayNode {
	Handle_PStandard_ArrayNode GetHandle() {
	return *(Handle_PStandard_ArrayNode*) &$self;
	}
};
%extend PStandard_ArrayNode {
	Standard_Integer __hash__() {
	return $self->HashCode(__PYTHONOCC_MAXINT__);
	}
};
%extend PStandard_ArrayNode {
	~PStandard_ArrayNode() {
	char *__env=getenv("PYTHONOCC_VERBOSE");
	if (__env){printf("## Call custom destructor for instance of PStandard_ArrayNode\n");}
	}
};