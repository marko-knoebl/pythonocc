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
%module StdSelect

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


%include StdSelect_dependencies.i


%include StdSelect_headers.i


enum StdSelect_TypeOfResult {
	StdSelect_TOR_SIMPLE,
	StdSelect_TOR_MULTIPLE,
	};

enum StdSelect_DisplayMode {
	StdSelect_DM_Wireframe,
	StdSelect_DM_Shading,
	StdSelect_DM_HLR,
	};

enum StdSelect_TypeOfEdge {
	StdSelect_AnyEdge,
	StdSelect_Line,
	StdSelect_Circle,
	};

enum StdSelect_TypeOfFace {
	StdSelect_AnyFace,
	StdSelect_Plane,
	StdSelect_Cylinder,
	StdSelect_Sphere,
	StdSelect_Torus,
	StdSelect_Revol,
	StdSelect_Cone,
	};



%nodefaultctor Handle_StdSelect_Shape;
class Handle_StdSelect_Shape : public Handle_PrsMgr_PresentableObject {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_Shape();
		%feature("autodoc", "1");
		Handle_StdSelect_Shape();
		%feature("autodoc", "1");
		Handle_StdSelect_Shape(const Handle_StdSelect_Shape &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_Shape(const StdSelect_Shape *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_Shape const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_Shape {
	StdSelect_Shape* GetObject() {
	return (StdSelect_Shape*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_SensitiveText2d;
class Handle_StdSelect_SensitiveText2d : public Handle_Select2D_SensitiveEntity {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_SensitiveText2d();
		%feature("autodoc", "1");
		Handle_StdSelect_SensitiveText2d();
		%feature("autodoc", "1");
		Handle_StdSelect_SensitiveText2d(const Handle_StdSelect_SensitiveText2d &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_SensitiveText2d(const StdSelect_SensitiveText2d *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_SensitiveText2d const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_SensitiveText2d {
	StdSelect_SensitiveText2d* GetObject() {
	return (StdSelect_SensitiveText2d*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_TextProjector2d;
class Handle_StdSelect_TextProjector2d : public Handle_Select2D_Projector {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_TextProjector2d();
		%feature("autodoc", "1");
		Handle_StdSelect_TextProjector2d();
		%feature("autodoc", "1");
		Handle_StdSelect_TextProjector2d(const Handle_StdSelect_TextProjector2d &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_TextProjector2d(const StdSelect_TextProjector2d *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_TextProjector2d const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_TextProjector2d {
	StdSelect_TextProjector2d* GetObject() {
	return (StdSelect_TextProjector2d*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_BRepOwner;
class Handle_StdSelect_BRepOwner : public Handle_SelectMgr_EntityOwner {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_BRepOwner();
		%feature("autodoc", "1");
		Handle_StdSelect_BRepOwner();
		%feature("autodoc", "1");
		Handle_StdSelect_BRepOwner(const Handle_StdSelect_BRepOwner &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_BRepOwner(const StdSelect_BRepOwner *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_BRepOwner const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_BRepOwner {
	StdSelect_BRepOwner* GetObject() {
	return (StdSelect_BRepOwner*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs;
class Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs : public Handle_TCollection_MapNode {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs();
		%feature("autodoc", "1");
		Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs();
		%feature("autodoc", "1");
		Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs(const Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs(const StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs {
	StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs* GetObject() {
	return (StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_FaceFilter;
class Handle_StdSelect_FaceFilter : public Handle_SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_FaceFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_FaceFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_FaceFilter(const Handle_StdSelect_FaceFilter &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_FaceFilter(const StdSelect_FaceFilter *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_FaceFilter const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_FaceFilter {
	StdSelect_FaceFilter* GetObject() {
	return (StdSelect_FaceFilter*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_ViewerSelector2d;
class Handle_StdSelect_ViewerSelector2d : public Handle_SelectMgr_ViewerSelector {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_ViewerSelector2d();
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector2d();
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector2d(const Handle_StdSelect_ViewerSelector2d &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector2d(const StdSelect_ViewerSelector2d *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector2d const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_ViewerSelector2d {
	StdSelect_ViewerSelector2d* GetObject() {
	return (StdSelect_ViewerSelector2d*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_ViewerSelector3d;
class Handle_StdSelect_ViewerSelector3d : public Handle_SelectMgr_ViewerSelector {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_ViewerSelector3d();
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector3d();
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector3d(const Handle_StdSelect_ViewerSelector3d &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector3d(const StdSelect_ViewerSelector3d *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_ViewerSelector3d const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_ViewerSelector3d {
	StdSelect_ViewerSelector3d* GetObject() {
	return (StdSelect_ViewerSelector3d*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_ShapeTypeFilter;
class Handle_StdSelect_ShapeTypeFilter : public Handle_SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_ShapeTypeFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_ShapeTypeFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_ShapeTypeFilter(const Handle_StdSelect_ShapeTypeFilter &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_ShapeTypeFilter(const StdSelect_ShapeTypeFilter *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_ShapeTypeFilter const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_ShapeTypeFilter {
	StdSelect_ShapeTypeFilter* GetObject() {
	return (StdSelect_ShapeTypeFilter*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_EdgeFilter;
class Handle_StdSelect_EdgeFilter : public Handle_SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_EdgeFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_EdgeFilter();
		%feature("autodoc", "1");
		Handle_StdSelect_EdgeFilter(const Handle_StdSelect_EdgeFilter &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_EdgeFilter(const StdSelect_EdgeFilter *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_EdgeFilter const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_EdgeFilter {
	StdSelect_EdgeFilter* GetObject() {
	return (StdSelect_EdgeFilter*)$self->Access();
	}
};

%nodefaultctor Handle_StdSelect_Prs;
class Handle_StdSelect_Prs : public Handle_Prs3d_Presentation {
	public:
		%feature("autodoc", "1");
		~Handle_StdSelect_Prs();
		%feature("autodoc", "1");
		Handle_StdSelect_Prs();
		%feature("autodoc", "1");
		Handle_StdSelect_Prs(const Handle_StdSelect_Prs &aHandle);
		%feature("autodoc", "1");
		Handle_StdSelect_Prs(const StdSelect_Prs *anItem);
		%feature("autodoc", "1");
		Handle_StdSelect_Prs const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_StdSelect_Prs {
	StdSelect_Prs* GetObject() {
	return (StdSelect_Prs*)$self->Access();
	}
};

%nodefaultctor StdSelect_IndexedDataMapOfOwnerPrs;
class StdSelect_IndexedDataMapOfOwnerPrs : public TCollection_BasicMap {
	public:
		%feature("autodoc", "1");
		StdSelect_IndexedDataMapOfOwnerPrs(const Standard_Integer NbBuckets=1);
		%feature("autodoc", "1");
		StdSelect_IndexedDataMapOfOwnerPrs & Assign(const StdSelect_IndexedDataMapOfOwnerPrs &Other);
		%feature("autodoc", "1");
		void ReSize(const Standard_Integer NbBuckets);
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		~StdSelect_IndexedDataMapOfOwnerPrs();
		%feature("autodoc", "1");
		Standard_Integer Add(const Handle_SelectBasics_EntityOwner &K, const Handle_StdSelect_Prs &I);
		%feature("autodoc", "1");
		void Substitute(const Standard_Integer I, const Handle_SelectBasics_EntityOwner &K, const Handle_StdSelect_Prs &T);
		%feature("autodoc", "1");
		void RemoveLast();
		%feature("autodoc", "1");
		Standard_Boolean Contains(const Handle_SelectBasics_EntityOwner &K) const;
		%feature("autodoc", "1");
		const Handle_SelectBasics_EntityOwner & FindKey(const Standard_Integer I) const;
		%feature("autodoc", "1");
		const Handle_StdSelect_Prs & FindFromIndex(const Standard_Integer I) const;
		%feature("autodoc", "1");
		const Handle_StdSelect_Prs & operator()(const Standard_Integer I) const;
		%feature("autodoc", "1");
		Handle_StdSelect_Prs & ChangeFromIndex(const Standard_Integer I);
		%feature("autodoc", "1");
		Handle_StdSelect_Prs & operator()(const Standard_Integer I);
		%feature("autodoc", "1");
		Standard_Integer FindIndex(const Handle_SelectBasics_EntityOwner &K) const;
		%feature("autodoc", "1");
		const Handle_StdSelect_Prs & FindFromKey(const Handle_SelectBasics_EntityOwner &K) const;
		%feature("autodoc", "1");
		Handle_StdSelect_Prs & ChangeFromKey(const Handle_SelectBasics_EntityOwner &K);

};

%nodefaultctor StdSelect_ShapeTypeFilter;
class StdSelect_ShapeTypeFilter : public SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		StdSelect_ShapeTypeFilter(const TopAbs_ShapeEnum aType);
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsOk(const Handle_SelectMgr_EntityOwner &anobj) const;
		%feature("autodoc", "1");
		TopAbs_ShapeEnum Type() const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean ActsOn(const TopAbs_ShapeEnum aStandardMode) const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_ShapeTypeFilter();

};
%extend StdSelect_ShapeTypeFilter {
	Handle_StdSelect_ShapeTypeFilter GetHandle() {
	return *(Handle_StdSelect_ShapeTypeFilter*) &$self;
	}
};

%nodefaultctor StdSelect;
class StdSelect {
	public:
		%feature("autodoc", "1");
		~StdSelect();
		%feature("autodoc", "1");
		StdSelect();
		%feature("autodoc", "1");
		Select3D_Projector GetProjector(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void SetDrawerForBRepOwner(const Handle_SelectMgr_Selection &aSelection, const Handle_Prs3d_Drawer &aDrawer);

};

%nodefaultctor StdSelect_BRepSelectionTool;
class StdSelect_BRepSelectionTool {
	public:
		%feature("autodoc", "1");
		~StdSelect_BRepSelectionTool();
		%feature("autodoc", "1");
		StdSelect_BRepSelectionTool();
		%feature("autodoc", "1");
		void Load(const Handle_SelectMgr_Selection &aSelection, const TopoDS_Shape &aShape, const TopAbs_ShapeEnum aType, const Standard_Boolean AutoTriangulation=1, const Standard_Integer aPriority=-0x000000001, const Standard_Integer NbPOnEdge=9, const Standard_Real MaximalParameter=500);
		%feature("autodoc", "1");
		void Load(const Handle_SelectMgr_Selection &aSelection, const Handle_SelectMgr_SelectableObject &Origin, const TopoDS_Shape &aShape, const TopAbs_ShapeEnum aType, const Standard_Boolean AutoTriangulation=1, const Standard_Integer aPriority=-0x000000001, const Standard_Integer NbPOnEdge=9, const Standard_Real MaximalParameter=500);
		%feature("autodoc", "1");
		Standard_Integer GetStandardPriority(const TopoDS_Shape &aShap, const TopAbs_ShapeEnum aType);
		%feature("autodoc", "1");
		void ComputeSensitive(const TopoDS_Shape &aShape, const Handle_StdSelect_BRepOwner &anOwner, const Handle_SelectMgr_Selection &aSelection, const Standard_Integer NbPOnEdge, const Standard_Real MaximalParameter, const Standard_Boolean AutoTriangulation=1);
		%feature("autodoc", "1");
		Standard_Boolean GetSensitiveForFace(const TopoDS_Face &aFace, const Handle_StdSelect_BRepOwner &anOwner, Select3D_ListOfSensitive & OutList, const Standard_Boolean AutoTriangulation=1, const Standard_Integer NbPOnEdge=9, const Standard_Real MaxiParam=500, const Standard_Boolean InteriorFlag=1);

};

%nodefaultctor StdSelect_FaceFilter;
class StdSelect_FaceFilter : public SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		StdSelect_FaceFilter(const StdSelect_TypeOfFace aTypeOfFace);
		%feature("autodoc", "1");
		void SetType(const StdSelect_TypeOfFace aNewType);
		%feature("autodoc", "1");
		StdSelect_TypeOfFace Type() const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsOk(const Handle_SelectMgr_EntityOwner &anobj) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean ActsOn(const TopAbs_ShapeEnum aStandardMode) const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_FaceFilter();

};
%extend StdSelect_FaceFilter {
	Handle_StdSelect_FaceFilter GetHandle() {
	return *(Handle_StdSelect_FaceFilter*) &$self;
	}
};

%nodefaultctor StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs;
class StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs : public TCollection_MapNode {
	public:
		%feature("autodoc", "1");
		StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs(const Handle_SelectBasics_EntityOwner &K1, const Standard_Integer K2, const Handle_StdSelect_Prs &I, const TCollection_MapNodePtr &n1, const TCollection_MapNodePtr &n2);
		%feature("autodoc", "1");
		Handle_SelectBasics_EntityOwner & Key1() const;
		%feature("autodoc", "1");
		Standard_Integer & Key2() const;
		%feature("autodoc", "1");
		TCollection_MapNodePtr & Next2() const;
		%feature("autodoc", "1");
		Handle_StdSelect_Prs & Value() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs();

};
%extend StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs {
	Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs GetHandle() {
	return *(Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs*) &$self;
	}
};

%nodefaultctor StdSelect_SensitiveText2d;
class StdSelect_SensitiveText2d : public Select2D_SensitiveEntity {
	public:
		%feature("autodoc", "1");
		StdSelect_SensitiveText2d(const Handle_SelectBasics_EntityOwner &anOwnerId, const TCollection_ExtendedString &aString, const Standard_Real XPox, const Standard_Real YPos, const Standard_Real Angle=0, const Standard_Integer aFontIndex=-0x000000001);
		%feature("autodoc", "1");
		virtual		Standard_Boolean NeedsConversion() const;
		%feature("autodoc", "1");
		virtual		void Convert(const Handle_Select2D_Projector &aTextProj);
		%feature("autodoc", "1");
		virtual		void Areas(SelectBasics_ListOfBox2d & aresult);
		%feature("autodoc", "1");
		virtual		Standard_Boolean Matches(const Standard_Real X, const Standard_Real Y, const Standard_Real aTol, Standard_Real &OutValue);
		%feature("autodoc", "1");
		virtual		Standard_Boolean Matches(const Standard_Real XMin, const Standard_Real YMin, const Standard_Real XMax, const Standard_Real YMax, const Standard_Real aTol);
		%feature("autodoc", "1");
		virtual		Standard_Boolean Matches(const TColgp_Array1OfPnt2d &Polyline, const Bnd_Box2d &aBox, const Standard_Real aTol);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_SensitiveText2d();

};
%extend StdSelect_SensitiveText2d {
	Handle_StdSelect_SensitiveText2d GetHandle() {
	return *(Handle_StdSelect_SensitiveText2d*) &$self;
	}
};

%nodefaultctor StdSelect_Shape;
class StdSelect_Shape : public PrsMgr_PresentableObject {
	public:
		%feature("autodoc", "1");
		StdSelect_Shape(const TopoDS_Shape &Sh);
		%feature("autodoc", "1");
		virtual		void Compute(const Handle_PrsMgr_PresentationManager3d &aPresentationManager, const Handle_Prs3d_Presentation &aPresentation, const Standard_Integer aMode=0);
		%feature("autodoc", "1");
		virtual		void Compute(const Handle_Prs3d_Projector &aProjector, const Handle_Geom_Transformation &aTrsf, const Handle_Prs3d_Presentation &aPresentation);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_Shape();

};
%extend StdSelect_Shape {
	Handle_StdSelect_Shape GetHandle() {
	return *(Handle_StdSelect_Shape*) &$self;
	}
};

%nodefaultctor StdSelect_Prs;
class StdSelect_Prs : public Prs3d_Presentation {
	public:
		%feature("autodoc", "1");
		StdSelect_Prs(const Handle_Graphic3d_StructureManager &aStructureManager);
		%feature("autodoc", "1");
		const Handle_Graphic3d_StructureManager & Manager() const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_Prs();

};
%extend StdSelect_Prs {
	Handle_StdSelect_Prs GetHandle() {
	return *(Handle_StdSelect_Prs*) &$self;
	}
};

%nodefaultctor StdSelect_TextProjector2d;
class StdSelect_TextProjector2d : public Select2D_Projector {
	public:
		%feature("autodoc", "1");
		StdSelect_TextProjector2d(const Handle_V2d_View &aView);
		%feature("autodoc", "1");
		void Set(const Handle_V2d_View &aView);
		%feature("autodoc", "1");
		void Set(const gp_Trsf2d &atrsf);
		%feature("autodoc", "1");
		virtual		void Convert(const gp_Pnt2d &aPointIn, gp_Pnt2d & aPointOut) const;
		%feature("autodoc", "1");
		virtual		void Convert(const TCollection_ExtendedString &aText, const Standard_Real XPos, const Standard_Real YPos, gp_Pnt2d & MinPoint, gp_Pnt2d & MaxPoint, const Standard_Integer afont=-0x000000001) const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_TextProjector2d();

};
%extend StdSelect_TextProjector2d {
	Handle_StdSelect_TextProjector2d GetHandle() {
	return *(Handle_StdSelect_TextProjector2d*) &$self;
	}
};

%nodefaultctor StdSelect_ViewerSelector2d;
class StdSelect_ViewerSelector2d : public SelectMgr_ViewerSelector {
	public:
		%feature("autodoc", "1");
		StdSelect_ViewerSelector2d();
		%feature("autodoc", "1");
		StdSelect_ViewerSelector2d(const Handle_Select2D_Projector &aProjector);
		%feature("autodoc", "1");
		void Set(const Standard_Integer aSensitivity);
		%feature("autodoc", "1");
		void Set(const Handle_Select2D_Projector &aProjector);
		%feature("autodoc", "1");
		virtual		void Convert(const Handle_SelectMgr_Selection &aSelection);
		%feature("autodoc", "1");
		void Pick(const Standard_Integer XPix, const Standard_Integer YPix, const Handle_V2d_View &aView);
		%feature("autodoc", "1");
		void Pick(const Standard_Integer XPMin, const Standard_Integer YPMin, const Standard_Integer XPMax, const Standard_Integer YPMax, const Handle_V2d_View &aView);
		%feature("autodoc", "1");
		Handle_Select2D_Projector Projector() const;
		%feature("autodoc", "1");
		void DisplayAreas(const Handle_V2d_View &aView);
		%feature("autodoc", "1");
		void ClearAreas();
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_ViewerSelector2d();

};
%extend StdSelect_ViewerSelector2d {
	Handle_StdSelect_ViewerSelector2d GetHandle() {
	return *(Handle_StdSelect_ViewerSelector2d*) &$self;
	}
};

%nodefaultctor StdSelect_ViewerSelector3d;
class StdSelect_ViewerSelector3d : public SelectMgr_ViewerSelector {
	public:
		%feature("autodoc", "1");
		StdSelect_ViewerSelector3d();
		%feature("autodoc", "1");
		StdSelect_ViewerSelector3d(const Select3D_Projector &aProj);
		%feature("autodoc", "1");
		void InitProj(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		virtual		void Convert(const Handle_SelectMgr_Selection &aSelection);
		%feature("autodoc", "1");
		void Set(const Standard_Integer aSensitivity);
		%feature("autodoc", "1");
		void Set(const Select3D_Projector &aProj);
		%feature("autodoc", "1");
		void Pick(const Standard_Integer XPix, const Standard_Integer YPix, const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void Pick(const Standard_Integer XPMin, const Standard_Integer YPMin, const Standard_Integer XPMax, const Standard_Integer YPMax, const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void Pick(const TColgp_Array1OfPnt2d &Polyline, const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		const Select3D_Projector & Projector() const;
		%feature("autodoc", "1");
		void ReactivateProjector();
		%feature("autodoc", "1");
		void DisplayAreas(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void ClearAreas(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void DisplaySensitive(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void ClearSensitive(const Handle_V3d_View &aView);
		%feature("autodoc", "1");
		void DisplaySensitive(const Handle_SelectMgr_Selection &aSel, const Handle_V3d_View &aView, const Standard_Boolean ClearOthers=1);
		%feature("autodoc", "1");
		void DisplayAreas(const Handle_SelectMgr_Selection &aSel, const Handle_V3d_View &aView, const Standard_Boolean ClearOthers=1);
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_ViewerSelector3d();

};
%extend StdSelect_ViewerSelector3d {
	Handle_StdSelect_ViewerSelector3d GetHandle() {
	return *(Handle_StdSelect_ViewerSelector3d*) &$self;
	}
};

%nodefaultctor StdSelect_BRepOwner;
class StdSelect_BRepOwner : public SelectMgr_EntityOwner {
	public:
		%feature("autodoc", "1");
		StdSelect_BRepOwner(const Standard_Integer aPriority);
		%feature("autodoc", "1");
		StdSelect_BRepOwner(const TopoDS_Shape &aShape, const Standard_Integer aPriority=0, const Standard_Boolean ComesFromDecomposition=0);
		%feature("autodoc", "1");
		StdSelect_BRepOwner(const TopoDS_Shape &aShape, const Handle_SelectMgr_SelectableObject &theOrigin, const Standard_Integer aPriority=0, const Standard_Boolean FromDecomposition=0);
		%feature("autodoc", "1");
		Standard_Boolean HasShape() const;
		%feature("autodoc", "1");
		Standard_Boolean ComesFromDecomposition() const;
		%feature("autodoc", "1");
		const TopoDS_Shape & Shape() const;
		%feature("autodoc", "1");
		Standard_Boolean HasHilightMode() const;
		%feature("autodoc", "1");
		void SetHilightMode(const Standard_Integer HiMod);
		%feature("autodoc", "1");
		void ResetHilightMode();
		%feature("autodoc", "1");
		Standard_Integer HilightMode() const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsHilighted(const Handle_PrsMgr_PresentationManager &aPM, const Standard_Integer aMode=0) const;
		%feature("autodoc", "1");
		virtual		void Hilight();
		%feature("autodoc", "1");
		virtual		void Hilight(const Handle_PrsMgr_PresentationManager &aPM, const Standard_Integer aMode=0);
		%feature("autodoc", "1");
		virtual		void HilightWithColor(const Handle_PrsMgr_PresentationManager3d &aPM, const Quantity_NameOfColor aCol, const Standard_Integer aMode=0);
		%feature("autodoc", "1");
		virtual		void Unhilight(const Handle_PrsMgr_PresentationManager &aPM, const Standard_Integer aMode=0);
		%feature("autodoc", "1");
		virtual		void Clear(const Handle_PrsMgr_PresentationManager &aPM, const Standard_Integer aMode=0);
		%feature("autodoc", "1");
		virtual		void SetLocation(const TopLoc_Location &aLoc);
		%feature("autodoc", "1");
		virtual		void ResetLocation();
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_BRepOwner();

};
%extend StdSelect_BRepOwner {
	Handle_StdSelect_BRepOwner GetHandle() {
	return *(Handle_StdSelect_BRepOwner*) &$self;
	}
};

%nodefaultctor StdSelect_BRepHilighter;
class StdSelect_BRepHilighter {
	public:
		%feature("autodoc", "1");
		~StdSelect_BRepHilighter();
		%feature("autodoc", "1");
		StdSelect_BRepHilighter();
		%feature("autodoc", "1");
		StdSelect_BRepHilighter(const Handle_StdSelect_ViewerSelector3d &aSelector, const Handle_V3d_Viewer &aViewer, const Quantity_NameOfColor acolor=Quantity_NOC_INDIANRED3, const StdSelect_TypeOfResult aType=StdSelect_TOR_SIMPLE);
		%feature("autodoc", "1");
		void Set(const Handle_StdSelect_ViewerSelector3d &aSelector);
		%feature("autodoc", "1");
		void Set(const Handle_V3d_Viewer &aViewer);
		%feature("autodoc", "1");
		void Set(const Quantity_NameOfColor acolor);
		%feature("autodoc", "1");
		void Set(const StdSelect_TypeOfResult atype);
		%feature("autodoc", "1");
		void Process();
		%feature("autodoc", "1");
		void Process(const Handle_V3d_View &aView, const Standard_Boolean DoubleBuffer=0);
		%feature("autodoc", "1");
		void Clear();
		%feature("autodoc", "1");
		const Handle_Prs3d_Drawer & Drawer() const;

};

%nodefaultctor StdSelect_EdgeFilter;
class StdSelect_EdgeFilter : public SelectMgr_Filter {
	public:
		%feature("autodoc", "1");
		StdSelect_EdgeFilter(const StdSelect_TypeOfEdge Edge);
		%feature("autodoc", "1");
		void SetType(const StdSelect_TypeOfEdge aNewType);
		%feature("autodoc", "1");
		StdSelect_TypeOfEdge Type() const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean IsOk(const Handle_SelectMgr_EntityOwner &anobj) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean ActsOn(const TopAbs_ShapeEnum aStandardMode) const;
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;
		%feature("autodoc", "1");
		virtual		~StdSelect_EdgeFilter();

};
%extend StdSelect_EdgeFilter {
	Handle_StdSelect_EdgeFilter GetHandle() {
	return *(Handle_StdSelect_EdgeFilter*) &$self;
	}
};