/*
##Copyright 2008-2009 Thomas Paviot
##
##thomas.paviot@free.fr
##
##pythonOCC is a computer program whose purpose is to provide a complete set
##of python bindings for OpenCascade library.
##
##This software is governed by the CeCILL license under French law and
##abiding by the rules of distribution of free software.  You can  use, 
##modify and/ or redistribute the software under the terms of the CeCILL
##license as circulated by CEA, CNRS and INRIA at the following URL
##"http://www.cecill.info". 
##
##As a counterpart to the access to the source code and  rights to copy,
##modify and redistribute granted by the license, users are provided only
##with a limited warranty  and the software's author,  the holder of the
##economic rights,  and the successive licensors  have only  limited
##liability. 
##
##In this respect, the user's attention is drawn to the risks associated
##with loading,  using,  modifying and/or developing or reproducing the
##software by the user in light of its specific status of free software,
##that may mean  that it is complicated to manipulate,  and  that  also
##therefore means  that it is reserved for developers  and  experienced
##professionals having in-depth computer knowledge. Users are therefore
##encouraged to load and test the software's suitability as regards their
##requirements in conditions enabling the security of their systems and/or 
##data to be ensured and,  more generally, to use and operate it in the 
##same conditions as regards security. 
##
##The fact that you are presently reading this means that you have had
##knowledge of the CeCILL license and that you accept its terms.
*/
%module PCollection

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


%include PCollection_dependencies.i


%include PCollection_headers.i


enum PCollection_Side {
	PCollection_Left,
	PCollection_Right,
	};

enum PCollection_AccessMode {
	PCollection_Read,
	PCollection_Update,
	};



%nodefaultctor Handle_PCollection_HAsciiString;
class Handle_PCollection_HAsciiString : public Handle_Standard_Persistent {
	public:
		%feature("autodoc", "1");
		~Handle_PCollection_HAsciiString();
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString();
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString(const Handle_PCollection_HAsciiString &aHandle);
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString(const PCollection_HAsciiString *anItem);
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString const DownCast(const Handle_Standard_Persistent &AnObject);

};
%extend Handle_PCollection_HAsciiString {
	PCollection_HAsciiString* GetObject() {
	return (PCollection_HAsciiString*)$self->Access();
	}
};

%nodefaultctor Handle_PCollection_HExtendedString;
class Handle_PCollection_HExtendedString : public Handle_Standard_Persistent {
	public:
		%feature("autodoc", "1");
		~Handle_PCollection_HExtendedString();
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString();
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString(const Handle_PCollection_HExtendedString &aHandle);
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString(const PCollection_HExtendedString *anItem);
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString const DownCast(const Handle_Standard_Persistent &AnObject);

};
%extend Handle_PCollection_HExtendedString {
	PCollection_HExtendedString* GetObject() {
	return (PCollection_HExtendedString*)$self->Access();
	}
};

%nodefaultctor Handle_PCollection_IsNotRoot;
class Handle_PCollection_IsNotRoot : public Handle_Standard_Failure {
	public:
		%feature("autodoc", "1");
		~Handle_PCollection_IsNotRoot();
		%feature("autodoc", "1");
		Handle_PCollection_IsNotRoot();
		%feature("autodoc", "1");
		Handle_PCollection_IsNotRoot(const Handle_PCollection_IsNotRoot &aHandle);
		%feature("autodoc", "1");
		Handle_PCollection_IsNotRoot(const PCollection_IsNotRoot *anItem);
		%feature("autodoc", "1");
		Handle_PCollection_IsNotRoot const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_PCollection_IsNotRoot {
	PCollection_IsNotRoot* GetObject() {
	return (PCollection_IsNotRoot*)$self->Access();
	}
};

%nodefaultctor Handle_PCollection_IsContained;
class Handle_PCollection_IsContained : public Handle_Standard_Failure {
	public:
		%feature("autodoc", "1");
		~Handle_PCollection_IsContained();
		%feature("autodoc", "1");
		Handle_PCollection_IsContained();
		%feature("autodoc", "1");
		Handle_PCollection_IsContained(const Handle_PCollection_IsContained &aHandle);
		%feature("autodoc", "1");
		Handle_PCollection_IsContained(const PCollection_IsContained *anItem);
		%feature("autodoc", "1");
		Handle_PCollection_IsContained const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_PCollection_IsContained {
	PCollection_IsContained* GetObject() {
	return (PCollection_IsContained*)$self->Access();
	}
};

%nodefaultctor Handle_PCollection_IsNullTree;
class Handle_PCollection_IsNullTree : public Handle_Standard_Failure {
	public:
		%feature("autodoc", "1");
		~Handle_PCollection_IsNullTree();
		%feature("autodoc", "1");
		Handle_PCollection_IsNullTree();
		%feature("autodoc", "1");
		Handle_PCollection_IsNullTree(const Handle_PCollection_IsNullTree &aHandle);
		%feature("autodoc", "1");
		Handle_PCollection_IsNullTree(const PCollection_IsNullTree *anItem);
		%feature("autodoc", "1");
		Handle_PCollection_IsNullTree const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_PCollection_IsNullTree {
	PCollection_IsNullTree* GetObject() {
	return (PCollection_IsNullTree*)$self->Access();
	}
};

%nodefaultctor PCollection_IsNullTree;
class PCollection_IsNullTree : public Standard_Failure {
	public:
		%feature("autodoc", "1");
		PCollection_IsNullTree();
		%feature("autodoc", "1");
		PCollection_IsNullTree(const char * AString);
		%feature("autodoc", "1");
		void Raise(const char * aMessage="");
		%feature("autodoc", "1");
		void Raise(Standard_SStream & aReason);
		%feature("autodoc", "1");
		Handle_PCollection_IsNullTree NewInstance(const char * aMessage);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~PCollection_IsNullTree();

};
%extend PCollection_IsNullTree {
	Handle_PCollection_IsNullTree GetHandle() {
	return *(Handle_PCollection_IsNullTree*) &$self;
	}
};

%nodefaultctor PCollection_PrivCompareOfInteger;
class PCollection_PrivCompareOfInteger {
	public:
		%feature("autodoc", "1");
		~PCollection_PrivCompareOfInteger();
		%feature("autodoc", "1");
		PCollection_PrivCompareOfInteger();
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsLower(const Standard_Integer &Left, const Standard_Integer &Right) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsGreater(const Standard_Integer &Left, const Standard_Integer &Right) const;
		%feature("autodoc", "1");
		Standard_Boolean IsEqual(const Standard_Integer &Left, const Standard_Integer &Right) const;

};

%nodefaultctor PCollection_IsNotRoot;
class PCollection_IsNotRoot : public Standard_Failure {
	public:
		%feature("autodoc", "1");
		PCollection_IsNotRoot();
		%feature("autodoc", "1");
		PCollection_IsNotRoot(const char * AString);
		%feature("autodoc", "1");
		void Raise(const char * aMessage="");
		%feature("autodoc", "1");
		void Raise(Standard_SStream & aReason);
		%feature("autodoc", "1");
		Handle_PCollection_IsNotRoot NewInstance(const char * aMessage);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~PCollection_IsNotRoot();

};
%extend PCollection_IsNotRoot {
	Handle_PCollection_IsNotRoot GetHandle() {
	return *(Handle_PCollection_IsNotRoot*) &$self;
	}
};

%nodefaultctor PCollection_IsContained;
class PCollection_IsContained : public Standard_Failure {
	public:
		%feature("autodoc", "1");
		PCollection_IsContained();
		%feature("autodoc", "1");
		PCollection_IsContained(const char * AString);
		%feature("autodoc", "1");
		void Raise(const char * aMessage="");
		%feature("autodoc", "1");
		void Raise(Standard_SStream & aReason);
		%feature("autodoc", "1");
		Handle_PCollection_IsContained NewInstance(const char * aMessage);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~PCollection_IsContained();

};
%extend PCollection_IsContained {
	Handle_PCollection_IsContained GetHandle() {
	return *(Handle_PCollection_IsContained*) &$self;
	}
};

%nodefaultctor PCollection_HAsciiString;
class PCollection_HAsciiString : public Standard_Persistent {
	public:
		%feature("autodoc", "1");
		PCollection_HAsciiString(const char * S);
		%feature("autodoc", "1");
		PCollection_HAsciiString(const TCollection_AsciiString &S);
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Standard_Character C);
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Handle_PCollection_HAsciiString &S, const Standard_Integer FromIndex, const Standard_Integer ToIndex);
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Standard_Real R, const char * F="%f");
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Standard_Integer I, const char * F="%d");
		%feature("autodoc", "1");
		void Append(const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		void Capitalize();
		%feature("autodoc", "1");
		void Center(const Standard_Integer Width, const Standard_Character Filler);
		%feature("autodoc", "1");
		void ChangeAll(const Standard_Character C, const Standard_Character NewC, const Standard_Boolean CaseSensitive);
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		TCollection_AsciiString Convert() const;
		%feature("autodoc", "1");
		Standard_Integer FirstLocationInSet(const Handle_PCollection_HAsciiString &Set, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Standard_Integer FirstLocationNotInSet(const Handle_PCollection_HAsciiString &Set, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		Standard_Integer IntegerValue() const;
		%feature("autodoc", "1");
		Standard_Boolean IsDifferent(const Handle_PCollection_HAsciiString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsEmpty() const;
		%feature("autodoc", "1");
		Standard_Boolean IsGreater(const Handle_PCollection_HAsciiString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsIntegerValue() const;
		%feature("autodoc", "1");
		Standard_Boolean IsLess(const Handle_PCollection_HAsciiString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsRealValue() const;
		%feature("autodoc", "1");
		Standard_Boolean IsSameString(const Handle_PCollection_HAsciiString &S) const;
		%feature("autodoc", "1");
		Standard_Boolean IsSameString(const Handle_PCollection_HAsciiString &S, const Standard_Boolean CaseSensitive) const;
		%feature("autodoc", "1");
		void LeftAdjust();
		%feature("autodoc", "1");
		void LeftJustify(const Standard_Integer Width, const Standard_Character Filler);
		%feature("autodoc", "1");
		Standard_Integer Length() const;
		%feature("autodoc", "1");
		Standard_Integer Location(const Standard_Integer N, const Standard_Character C, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Standard_Integer Location(const Handle_PCollection_HAsciiString &S, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		void Lowercase();
		%feature("autodoc", "1");
		void Prepend(const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		void Print(Standard_OStream & S) const;
		%feature("autodoc", "1");
		Standard_Real RealValue() const;
		%feature("autodoc", "1");
		void Remove(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer FromIndex, const Standard_Integer ToIndex);
		%feature("autodoc", "1");
		void RemoveAll(const Standard_Character C, const Standard_Boolean CaseSensitive);
		%feature("autodoc", "1");
		void RightAdjust();
		%feature("autodoc", "1");
		void RightJustify(const Standard_Integer Width, const Standard_Character Filler);
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const Standard_Character C);
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString Split(const Standard_Integer Index);
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString SubString(const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Handle_PCollection_HAsciiString Token(const char * separators=" \011", const Standard_Integer whichone=1) const;
		%feature("autodoc", "1");
		void Uppercase();
		%feature("autodoc", "1");
		Standard_Integer UsefullLength() const;
		%feature("autodoc", "1");
		Standard_Character Value(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		virtual		void ShallowDump(Standard_OStream & s) const;
		%feature("autodoc", "1");
		PCollection_HAsciiString();
		%feature("autodoc", "1");
		PCollection_HAsciiString(const Storage_stCONSTclCOM &a);
		%feature("autodoc", "1");
		const DBC_VArrayOfCharacter & _CSFDB_GetPCollection_HAsciiStringData() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~PCollection_HAsciiString();

};
%extend PCollection_HAsciiString {
	Handle_PCollection_HAsciiString GetHandle() {
	return *(Handle_PCollection_HAsciiString*) &$self;
	}
};

%nodefaultctor PCollection_CompareOfInteger;
class PCollection_CompareOfInteger : public PCollection_PrivCompareOfInteger {
	public:
		%feature("autodoc", "1");
		~PCollection_CompareOfInteger();
		%feature("autodoc", "1");
		PCollection_CompareOfInteger();
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsLower(const Standard_Integer &Left, const Standard_Integer &Right) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsGreater(const Standard_Integer &Left, const Standard_Integer &Right) const;

};

%nodefaultctor PCollection_PrivCompareOfReal;
class PCollection_PrivCompareOfReal {
	public:
		%feature("autodoc", "1");
		~PCollection_PrivCompareOfReal();
		%feature("autodoc", "1");
		PCollection_PrivCompareOfReal();
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsLower(const Standard_Real &Left, const Standard_Real &Right) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsGreater(const Standard_Real &Left, const Standard_Real &Right) const;
		%feature("autodoc", "1");
		Standard_Boolean IsEqual(const Standard_Real &Left, const Standard_Real &Right) const;

};

%nodefaultctor PCollection_CompareOfReal;
class PCollection_CompareOfReal : public PCollection_PrivCompareOfReal {
	public:
		%feature("autodoc", "1");
		~PCollection_CompareOfReal();
		%feature("autodoc", "1");
		PCollection_CompareOfReal();

};

%nodefaultctor PCollection_HExtendedString;
class PCollection_HExtendedString : public Standard_Persistent {
	public:
		%feature("autodoc", "1");
		PCollection_HExtendedString(const TCollection_ExtendedString &S);
		%feature("autodoc", "1");
		PCollection_HExtendedString(const Standard_ExtCharacter C);
		%feature("autodoc", "1");
		PCollection_HExtendedString(const Handle_PCollection_HExtendedString &S, const Standard_Integer FromIndex, const Standard_Integer ToIndex);
		%feature("autodoc", "1");
		PCollection_HExtendedString(const char * astring);
		%feature("autodoc", "1");
		PCollection_HExtendedString(const Handle_PCollection_HAsciiString &S);
		%feature("autodoc", "1");
		void Append(const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		void Center(const Standard_Integer Width, const Standard_ExtCharacter Filler);
		%feature("autodoc", "1");
		void ChangeAll(const Standard_ExtCharacter C, const Standard_ExtCharacter NewC);
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		TCollection_ExtendedString Convert() const;
		%feature("autodoc", "1");
		Standard_Integer FirstLocationInSet(const Handle_PCollection_HExtendedString &Set, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Standard_Integer FirstLocationNotInSet(const Handle_PCollection_HExtendedString &Set, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		Standard_Boolean IsAscii() const;
		%feature("autodoc", "1");
		Standard_Boolean IsDifferent(const Handle_PCollection_HExtendedString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsEmpty() const;
		%feature("autodoc", "1");
		Standard_Boolean IsGreater(const Handle_PCollection_HExtendedString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsLess(const Handle_PCollection_HExtendedString &other) const;
		%feature("autodoc", "1");
		Standard_Boolean IsSameString(const Handle_PCollection_HExtendedString &S) const;
		%feature("autodoc", "1");
		void LeftAdjust();
		%feature("autodoc", "1");
		void LeftJustify(const Standard_Integer Width, const Standard_ExtCharacter Filler);
		%feature("autodoc", "1");
		Standard_Integer Length() const;
		%feature("autodoc", "1");
		Standard_Integer Location(const Standard_Integer N, const Standard_ExtCharacter C, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Standard_Integer Location(const Handle_PCollection_HExtendedString &S, const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		void Prepend(const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		void Print(Standard_OStream & S) const;
		%feature("autodoc", "1");
		void Remove(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer FromIndex, const Standard_Integer ToIndex);
		%feature("autodoc", "1");
		void RemoveAll(const Standard_ExtCharacter C);
		%feature("autodoc", "1");
		void RightAdjust();
		%feature("autodoc", "1");
		void RightJustify(const Standard_Integer Width, const Standard_ExtCharacter Filler);
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const Standard_ExtCharacter C);
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const Handle_PCollection_HExtendedString &S);
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString Split(const Standard_Integer Index);
		%feature("autodoc", "1");
		Handle_PCollection_HExtendedString SubString(const Standard_Integer FromIndex, const Standard_Integer ToIndex) const;
		%feature("autodoc", "1");
		Standard_Integer UsefullLength() const;
		%feature("autodoc", "1");
		Standard_ExtCharacter Value(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		virtual		void ShallowDump(Standard_OStream & s) const;
		%feature("autodoc", "1");
		PCollection_HExtendedString();
		%feature("autodoc", "1");
		PCollection_HExtendedString(const Storage_stCONSTclCOM &a);
		%feature("autodoc", "1");
		const DBC_VArrayOfExtCharacter & _CSFDB_GetPCollection_HExtendedStringData() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~PCollection_HExtendedString();

};
%extend PCollection_HExtendedString {
	Handle_PCollection_HExtendedString GetHandle() {
	return *(Handle_PCollection_HExtendedString*) &$self;
	}
};