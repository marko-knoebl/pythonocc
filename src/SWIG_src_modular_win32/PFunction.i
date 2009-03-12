/*

Copyright 2008-2009 Thomas Paviot (thomas.paviot@free.fr)

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
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

*/
%module PFunction

%include typemaps.i
%include cmalloc.i
%include cpointer.i
%include carrays.i
%include exception.i

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


%include PFunction_dependencies.i


%include PFunction_headers.i




%nodefaultctor Handle_PFunction_Function;
class Handle_PFunction_Function : public Handle_PDF_Attribute {
	public:
		%feature("autodoc", "1");
		Handle_PFunction_Function();
		%feature("autodoc", "1");
		Handle_PFunction_Function(const Handle_PFunction_Function &aHandle);
		%feature("autodoc", "1");
		Handle_PFunction_Function(const PFunction_Function *anItem);
		%feature("autodoc", "1");
		Handle_PFunction_Function const DownCast(const Handle_Standard_Persistent &AnObject);

};
%extend Handle_PFunction_Function {
	PFunction_Function* GetObject() {
	return (PFunction_Function*)$self->Access();
	}
};
%extend Handle_PFunction_Function {
	~Handle_PFunction_Function() {
	printf("Call custom destructor for instance of Handle_PFunction_Function\n");
	}
};

%nodefaultctor PFunction_Function;
class PFunction_Function : public PDF_Attribute {
	public:
		%feature("autodoc", "1");
		PFunction_Function();
		%feature("autodoc", "1");
		void SetDriverGUID(const Standard_GUID &driverGUID);
		%feature("autodoc", "1");
		Standard_GUID GetDriverGUID() const;
		%feature("autodoc", "1");
		Standard_Integer GetFailure() const;
		%feature("autodoc", "1");
		void SetFailure(const Standard_Integer mode);
		%feature("autodoc", "1");
		PFunction_Function(const Storage_stCONSTclCOM &a);
		%feature("autodoc", "1");
		const Standard_GUID & _CSFDB_GetPFunction_FunctionmyDriverGUID() const;
		%feature("autodoc", "1");
		Standard_Integer _CSFDB_GetPFunction_FunctionmyFailure() const;
		%feature("autodoc", "1");
		void _CSFDB_SetPFunction_FunctionmyFailure(const Standard_Integer p);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;

};
%extend PFunction_Function {
	Handle_PFunction_Function GetHandle() {
	return *(Handle_PFunction_Function*) &$self;
	}
};
%extend PFunction_Function {
	~PFunction_Function() {
	printf("Call custom destructor for instance of PFunction_Function\n");
	}
};