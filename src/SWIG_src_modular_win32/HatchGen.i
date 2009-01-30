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
%module HatchGen

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


%include HatchGen_dependencies.i


%include HatchGen_headers.i


enum HatchGen_IntersectionType {
	HatchGen_TRUE,
	HatchGen_TOUCH,
	HatchGen_TANGENT,
	HatchGen_UNDETERMINED,
	};

enum HatchGen_ErrorStatus {
	HatchGen_NoProblem,
	HatchGen_TrimFailure,
	HatchGen_TransitionFailure,
	HatchGen_IncoherentParity,
	HatchGen_IncompatibleStates,
	};



%nodefaultctor Handle_HatchGen_SequenceNodeOfDomains;
class Handle_HatchGen_SequenceNodeOfDomains : public Handle_TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		~Handle_HatchGen_SequenceNodeOfDomains();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfDomains();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfDomains(const Handle_HatchGen_SequenceNodeOfDomains &aHandle);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfDomains(const HatchGen_SequenceNodeOfDomains *anItem);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfDomains const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_HatchGen_SequenceNodeOfDomains {
	HatchGen_SequenceNodeOfDomains* GetObject() {
	return (HatchGen_SequenceNodeOfDomains*)$self->Access();
	}
};

%nodefaultctor Handle_HatchGen_SequenceNodeOfPointsOnElement;
class Handle_HatchGen_SequenceNodeOfPointsOnElement : public Handle_TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		~Handle_HatchGen_SequenceNodeOfPointsOnElement();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnElement();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnElement(const Handle_HatchGen_SequenceNodeOfPointsOnElement &aHandle);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnElement(const HatchGen_SequenceNodeOfPointsOnElement *anItem);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnElement const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_HatchGen_SequenceNodeOfPointsOnElement {
	HatchGen_SequenceNodeOfPointsOnElement* GetObject() {
	return (HatchGen_SequenceNodeOfPointsOnElement*)$self->Access();
	}
};

%nodefaultctor Handle_HatchGen_SequenceNodeOfPointsOnHatching;
class Handle_HatchGen_SequenceNodeOfPointsOnHatching : public Handle_TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		~Handle_HatchGen_SequenceNodeOfPointsOnHatching();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnHatching();
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnHatching(const Handle_HatchGen_SequenceNodeOfPointsOnHatching &aHandle);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnHatching(const HatchGen_SequenceNodeOfPointsOnHatching *anItem);
		%feature("autodoc", "1");
		Handle_HatchGen_SequenceNodeOfPointsOnHatching const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_HatchGen_SequenceNodeOfPointsOnHatching {
	HatchGen_SequenceNodeOfPointsOnHatching* GetObject() {
	return (HatchGen_SequenceNodeOfPointsOnHatching*)$self->Access();
	}
};

%nodefaultctor HatchGen_PointsOnHatching;
class HatchGen_PointsOnHatching : public TCollection_BaseSequence {
	public:
		%feature("autodoc", "1");
		HatchGen_PointsOnHatching();
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		~HatchGen_PointsOnHatching();
		%feature("autodoc", "1");
		const HatchGen_PointsOnHatching & Assign(const HatchGen_PointsOnHatching &Other);
		%feature("autodoc", "1");
		void Append(const HatchGen_PointOnHatching &T);
		%feature("autodoc", "1");
		void Append(HatchGen_PointsOnHatching & S);
		%feature("autodoc", "1");
		void Prepend(const HatchGen_PointOnHatching &T);
		%feature("autodoc", "1");
		void Prepend(HatchGen_PointsOnHatching & S);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, const HatchGen_PointOnHatching &I);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, HatchGen_PointsOnHatching & S);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, const HatchGen_PointOnHatching &T);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, HatchGen_PointsOnHatching & S);
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & First() const;
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & Last() const;
		%feature("autodoc", "1");
		void Split(const Standard_Integer Index, HatchGen_PointsOnHatching & S);
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & Value(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & operator()(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const HatchGen_PointOnHatching &I);
		%feature("autodoc", "1");
		HatchGen_PointOnHatching & ChangeValue(const Standard_Integer Index);
		%feature("autodoc", "1");
		HatchGen_PointOnHatching & operator()(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer FromIndex, const Standard_Integer ToIndex);

};

%nodefaultctor HatchGen_Domains;
class HatchGen_Domains : public TCollection_BaseSequence {
	public:
		%feature("autodoc", "1");
		HatchGen_Domains();
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		~HatchGen_Domains();
		%feature("autodoc", "1");
		const HatchGen_Domains & Assign(const HatchGen_Domains &Other);
		%feature("autodoc", "1");
		void Append(const HatchGen_Domain &T);
		%feature("autodoc", "1");
		void Append(HatchGen_Domains & S);
		%feature("autodoc", "1");
		void Prepend(const HatchGen_Domain &T);
		%feature("autodoc", "1");
		void Prepend(HatchGen_Domains & S);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, const HatchGen_Domain &I);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, HatchGen_Domains & S);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, const HatchGen_Domain &T);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, HatchGen_Domains & S);
		%feature("autodoc", "1");
		const HatchGen_Domain & First() const;
		%feature("autodoc", "1");
		const HatchGen_Domain & Last() const;
		%feature("autodoc", "1");
		void Split(const Standard_Integer Index, HatchGen_Domains & S);
		%feature("autodoc", "1");
		const HatchGen_Domain & Value(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		const HatchGen_Domain & operator()(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const HatchGen_Domain &I);
		%feature("autodoc", "1");
		HatchGen_Domain & ChangeValue(const Standard_Integer Index);
		%feature("autodoc", "1");
		HatchGen_Domain & operator()(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer FromIndex, const Standard_Integer ToIndex);

};

%nodefaultctor HatchGen_IntersectionPoint;
class HatchGen_IntersectionPoint {
	public:
		%feature("autodoc", "1");
		void SetIndex(const Standard_Integer Index);
		%feature("autodoc", "1");
		Standard_Integer Index() const;
		%feature("autodoc", "1");
		void SetParameter(const Standard_Real Parameter);
		%feature("autodoc", "1");
		Standard_Real Parameter() const;
		%feature("autodoc", "1");
		void SetPosition(const TopAbs_Orientation Position);
		%feature("autodoc", "1");
		TopAbs_Orientation Position() const;
		%feature("autodoc", "1");
		void SetStateBefore(const TopAbs_State State);
		%feature("autodoc", "1");
		TopAbs_State StateBefore() const;
		%feature("autodoc", "1");
		void SetStateAfter(const TopAbs_State State);
		%feature("autodoc", "1");
		TopAbs_State StateAfter() const;
		%feature("autodoc", "1");
		void SetSegmentBeginning(const Standard_Boolean State=1);
		%feature("autodoc", "1");
		Standard_Boolean SegmentBeginning() const;
		%feature("autodoc", "1");
		void SetSegmentEnd(const Standard_Boolean State=1);
		%feature("autodoc", "1");
		Standard_Boolean SegmentEnd() const;
		%feature("autodoc", "1");
		virtual		void Dump(const Standard_Integer Index=0) const;

};

%nodefaultctor HatchGen_PointOnHatching;
class HatchGen_PointOnHatching : public HatchGen_IntersectionPoint {
	public:
		%feature("autodoc", "1");
		HatchGen_PointOnHatching();
		%feature("autodoc", "1");
		HatchGen_PointOnHatching(const HatchGen_PointOnHatching &Point);
		%feature("autodoc", "1");
		HatchGen_PointOnHatching(const IntRes2d_IntersectionPoint &Point);
		%feature("autodoc", "1");
		virtual		void Delete();
		%feature("autodoc", "1");
		virtual		~HatchGen_PointOnHatching();
		%feature("autodoc", "1");
		void AddPoint(const HatchGen_PointOnElement &Point, const Standard_Real Confusion);
		%feature("autodoc", "1");
		Standard_Integer NbPoints() const;
		%feature("autodoc", "1");
		const HatchGen_PointOnElement & Point(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		void RemPoint(const Standard_Integer Index);
		%feature("autodoc", "1");
		void ClrPoints();
		%feature("autodoc", "1");
		Standard_Boolean IsLower(const HatchGen_PointOnHatching &Point, const Standard_Real Confusion) const;
		%feature("autodoc", "1");
		Standard_Boolean IsEqual(const HatchGen_PointOnHatching &Point, const Standard_Real Confusion) const;
		%feature("autodoc", "1");
		Standard_Boolean IsGreater(const HatchGen_PointOnHatching &Point, const Standard_Real Confusion) const;

};

%nodefaultctor HatchGen_PointOnElement;
class HatchGen_PointOnElement : public HatchGen_IntersectionPoint {
	public:
		%feature("autodoc", "1");
		~HatchGen_PointOnElement();
		%feature("autodoc", "1");
		HatchGen_PointOnElement();
		%feature("autodoc", "1");
		HatchGen_PointOnElement(const HatchGen_PointOnElement &Point);
		%feature("autodoc", "1");
		HatchGen_PointOnElement(const IntRes2d_IntersectionPoint &Point);
		%feature("autodoc", "1");
		void SetIntersectionType(const HatchGen_IntersectionType Type);
		%feature("autodoc", "1");
		HatchGen_IntersectionType IntersectionType() const;
		%feature("autodoc", "1");
		Standard_Boolean IsIdentical(const HatchGen_PointOnElement &Point, const Standard_Real Confusion) const;
		%feature("autodoc", "1");
		Standard_Boolean IsDifferent(const HatchGen_PointOnElement &Point, const Standard_Real Confusion) const;
		%feature("autodoc", "1");
		virtual		void Dump(const Standard_Integer Index=0) const;

};

%nodefaultctor HatchGen_SequenceNodeOfPointsOnElement;
class HatchGen_SequenceNodeOfPointsOnElement : public TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		HatchGen_SequenceNodeOfPointsOnElement(const HatchGen_PointOnElement &I, const TCollection_SeqNodePtr &n, const TCollection_SeqNodePtr &p);
		%feature("autodoc", "1");
		HatchGen_PointOnElement & Value() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~HatchGen_SequenceNodeOfPointsOnElement();

};
%extend HatchGen_SequenceNodeOfPointsOnElement {
	Handle_HatchGen_SequenceNodeOfPointsOnElement GetHandle() {
	return *(Handle_HatchGen_SequenceNodeOfPointsOnElement*) &$self;
	}
};

%nodefaultctor HatchGen_PointsOnElement;
class HatchGen_PointsOnElement : public TCollection_BaseSequence {
	public:
		%feature("autodoc", "1");
		HatchGen_PointsOnElement();
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		~HatchGen_PointsOnElement();
		%feature("autodoc", "1");
		const HatchGen_PointsOnElement & Assign(const HatchGen_PointsOnElement &Other);
		%feature("autodoc", "1");
		void Append(const HatchGen_PointOnElement &T);
		%feature("autodoc", "1");
		void Append(HatchGen_PointsOnElement & S);
		%feature("autodoc", "1");
		void Prepend(const HatchGen_PointOnElement &T);
		%feature("autodoc", "1");
		void Prepend(HatchGen_PointsOnElement & S);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, const HatchGen_PointOnElement &I);
		%feature("autodoc", "1");
		void InsertBefore(const Standard_Integer Index, HatchGen_PointsOnElement & S);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, const HatchGen_PointOnElement &T);
		%feature("autodoc", "1");
		void InsertAfter(const Standard_Integer Index, HatchGen_PointsOnElement & S);
		%feature("autodoc", "1");
		const HatchGen_PointOnElement & First() const;
		%feature("autodoc", "1");
		const HatchGen_PointOnElement & Last() const;
		%feature("autodoc", "1");
		void Split(const Standard_Integer Index, HatchGen_PointsOnElement & S);
		%feature("autodoc", "1");
		const HatchGen_PointOnElement & Value(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		const HatchGen_PointOnElement & operator()(const Standard_Integer Index) const;
		%feature("autodoc", "1");
		void SetValue(const Standard_Integer Index, const HatchGen_PointOnElement &I);
		%feature("autodoc", "1");
		HatchGen_PointOnElement & ChangeValue(const Standard_Integer Index);
		%feature("autodoc", "1");
		HatchGen_PointOnElement & operator()(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer Index);
		%feature("autodoc", "1");
		void Remove(const Standard_Integer FromIndex, const Standard_Integer ToIndex);

};

%nodefaultctor HatchGen_SequenceNodeOfDomains;
class HatchGen_SequenceNodeOfDomains : public TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		HatchGen_SequenceNodeOfDomains(const HatchGen_Domain &I, const TCollection_SeqNodePtr &n, const TCollection_SeqNodePtr &p);
		%feature("autodoc", "1");
		HatchGen_Domain & Value() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~HatchGen_SequenceNodeOfDomains();

};
%extend HatchGen_SequenceNodeOfDomains {
	Handle_HatchGen_SequenceNodeOfDomains GetHandle() {
	return *(Handle_HatchGen_SequenceNodeOfDomains*) &$self;
	}
};

%nodefaultctor HatchGen_Domain;
class HatchGen_Domain {
	public:
		%feature("autodoc", "1");
		~HatchGen_Domain();
		%feature("autodoc", "1");
		HatchGen_Domain();
		%feature("autodoc", "1");
		HatchGen_Domain(const HatchGen_PointOnHatching &P1, const HatchGen_PointOnHatching &P2);
		%feature("autodoc", "1");
		HatchGen_Domain(const HatchGen_PointOnHatching &P, const Standard_Boolean First);
		%feature("autodoc", "1");
		void SetPoints(const HatchGen_PointOnHatching &P1, const HatchGen_PointOnHatching &P2);
		%feature("autodoc", "1");
		void SetPoints();
		%feature("autodoc", "1");
		void SetFirstPoint(const HatchGen_PointOnHatching &P);
		%feature("autodoc", "1");
		void SetFirstPoint();
		%feature("autodoc", "1");
		void SetSecondPoint(const HatchGen_PointOnHatching &P);
		%feature("autodoc", "1");
		void SetSecondPoint();
		%feature("autodoc", "1");
		Standard_Boolean HasFirstPoint() const;
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & FirstPoint() const;
		%feature("autodoc", "1");
		Standard_Boolean HasSecondPoint() const;
		%feature("autodoc", "1");
		const HatchGen_PointOnHatching & SecondPoint() const;
		%feature("autodoc", "1");
		void Dump(const Standard_Integer Index=0) const;

};

%nodefaultctor HatchGen_SequenceNodeOfPointsOnHatching;
class HatchGen_SequenceNodeOfPointsOnHatching : public TCollection_SeqNode {
	public:
		%feature("autodoc", "1");
		HatchGen_SequenceNodeOfPointsOnHatching(const HatchGen_PointOnHatching &I, const TCollection_SeqNodePtr &n, const TCollection_SeqNodePtr &p);
		%feature("autodoc", "1");
		HatchGen_PointOnHatching & Value() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~HatchGen_SequenceNodeOfPointsOnHatching();

};
%extend HatchGen_SequenceNodeOfPointsOnHatching {
	Handle_HatchGen_SequenceNodeOfPointsOnHatching GetHandle() {
	return *(Handle_HatchGen_SequenceNodeOfPointsOnHatching*) &$self;
	}
};