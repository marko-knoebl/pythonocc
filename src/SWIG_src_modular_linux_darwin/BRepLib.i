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
%module BRepLib

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


%include BRepLib_dependencies.i


%include BRepLib_headers.i


enum BRepLib_EdgeError {
	BRepLib_EdgeDone,
	BRepLib_PointProjectionFailed,
	BRepLib_ParameterOutOfRange,
	BRepLib_DifferentPointsOnClosedCurve,
	BRepLib_PointWithInfiniteParameter,
	BRepLib_DifferentsPointAndParameter,
	BRepLib_LineThroughIdenticPoints,
	};

enum BRepLib_FaceError {
	BRepLib_FaceDone,
	BRepLib_NoFace,
	BRepLib_NotPlanar,
	BRepLib_CurveProjectionFailed,
	BRepLib_ParametersOutOfRange,
	BRepLib_SurfaceNotC2,
	};

enum BRepLib_WireError {
	BRepLib_WireDone,
	BRepLib_EmptyWire,
	BRepLib_DisconnectedWire,
	BRepLib_NonManifoldWire,
	};

enum BRepLib_ShapeModification {
	BRepLib_Preserved,
	BRepLib_Deleted,
	BRepLib_Trimmed,
	BRepLib_Merged,
	BRepLib_BoundaryModified,
	};

enum BRepLib_ShellError {
	BRepLib_ShellDone,
	BRepLib_EmptyShell,
	BRepLib_DisconnectedShell,
	BRepLib_ShellParametersOutOfRange,
	};



%nodefaultctor BRepLib_Command;
class BRepLib_Command {
	public:
		%feature("autodoc", "1");
		virtual		void Delete();
		%feature("autodoc", "1");
		virtual		~BRepLib_Command();
		%feature("autodoc", "1");
		Standard_Boolean IsDone() const;
		%feature("autodoc", "1");
		void Check() const;

};

%nodefaultctor BRepLib_MakeShape;
class BRepLib_MakeShape : public BRepLib_Command {
	public:
		%feature("autodoc", "1");
		void Build();
		%feature("autodoc", "1");
		const TopoDS_Shape & Shape() const;
		%feature("autodoc", "1");
		virtual		BRepLib_ShapeModification FaceStatus(const TopoDS_Face &F) const;
		%feature("autodoc", "1");
		virtual		Standard_Boolean HasDescendants(const TopoDS_Face &F) const;
		%feature("autodoc", "1");
		virtual		const TopTools_ListOfShape & DescendantFaces(const TopoDS_Face &F);
		%feature("autodoc", "1");
		virtual		Standard_Integer NbSurfaces() const;
		%feature("autodoc", "1");
		virtual		const TopTools_ListOfShape & NewFaces(const Standard_Integer I);
		%feature("autodoc", "1");
		virtual		const TopTools_ListOfShape & FacesFromEdges(const TopoDS_Edge &E);
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeShape();

};

%nodefaultctor BRepLib_MakeVertex;
class BRepLib_MakeVertex : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeVertex(const gp_Pnt &P);
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeVertex();

};

%nodefaultctor BRepLib_MakeEdge;
class BRepLib_MakeEdge : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeEdge();
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Lin &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Lin &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Lin &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Lin &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Circ &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Circ &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Circ &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Circ &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Elips &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Elips &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Elips &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Elips &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Hypr &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Hypr &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Hypr &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Hypr &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Parab &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Parab &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Parab &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const gp_Parab &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L, const gp_Pnt &P1, const gp_Pnt &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom_Curve &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S, const gp_Pnt &P1, const gp_Pnt &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge(const Handle_Geom2d_Curve &L, const Handle_Geom_Surface &S, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C, const gp_Pnt &P1, const gp_Pnt &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Curve &C, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S, const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S, const gp_Pnt &P1, const gp_Pnt &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Handle_Geom_Surface &S, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_EdgeError Error() const;
		%feature("autodoc", "1");
		const TopoDS_Edge & Edge() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex1() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex2() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeEdge();

};

%nodefaultctor BRepLib_MakeEdge2d;
class BRepLib_MakeEdge2d : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Lin2d &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Lin2d &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Lin2d &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Lin2d &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Circ2d &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Circ2d &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Circ2d &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Circ2d &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Elips2d &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Elips2d &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Elips2d &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Elips2d &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Hypr2d &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Hypr2d &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Hypr2d &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Hypr2d &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Parab2d &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Parab2d &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Parab2d &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const gp_Parab2d &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L, const gp_Pnt2d &P1, const gp_Pnt2d &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_MakeEdge2d(const Handle_Geom2d_Curve &L, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const gp_Pnt2d &P1, const gp_Pnt2d &P2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const gp_Pnt2d &P1, const gp_Pnt2d &P2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		void Init(const Handle_Geom2d_Curve &C, const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const Standard_Real p1, const Standard_Real p2);
		%feature("autodoc", "1");
		BRepLib_EdgeError Error() const;
		%feature("autodoc", "1");
		const TopoDS_Edge & Edge() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex1() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex2() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeEdge2d();

};

%nodefaultctor BRepLib_MakeShell;
class BRepLib_MakeShell : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeShell();
		%feature("autodoc", "1");
		BRepLib_MakeShell(const Handle_Geom_Surface &S, const Standard_Boolean Segment=0);
		%feature("autodoc", "1");
		BRepLib_MakeShell(const Handle_Geom_Surface &S, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax, const Standard_Boolean Segment=0);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Surface &S, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax, const Standard_Boolean Segment=0);
		%feature("autodoc", "1");
		BRepLib_ShellError Error() const;
		%feature("autodoc", "1");
		const TopoDS_Shell & Shell() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeShell();

};

%nodefaultctor BRepLib_FuseEdges;
class BRepLib_FuseEdges {
	public:
		%feature("autodoc", "1");
		~BRepLib_FuseEdges();
		%feature("autodoc", "1");
		BRepLib_FuseEdges(const TopoDS_Shape &theShape, const Standard_Boolean PerformNow=0);
		%feature("autodoc", "1");
		void AvoidEdges(const TopTools_IndexedMapOfShape &theMapEdg);
		%feature("autodoc", "1");
		void SetConcatBSpl(const Standard_Boolean theConcatBSpl=1);
		%feature("autodoc", "1");
		void Edges(TopTools_DataMapOfIntegerListOfShape & theMapLstEdg);
		%feature("autodoc", "1");
		void ResultEdges(TopTools_DataMapOfIntegerShape & theMapEdg);
		%feature("autodoc", "1");
		void Faces(TopTools_DataMapOfShapeShape & theMapFac);
		%feature("autodoc", "1");
		TopoDS_Shape & Shape();
		%feature("autodoc", "1");
		Standard_Integer const NbVertices();
		%feature("autodoc", "1");
		void Perform();

};

%nodefaultctor BRepLib;
class BRepLib {
	public:
		%feature("autodoc", "1");
		~BRepLib();
		%feature("autodoc", "1");
		BRepLib();
		%feature("autodoc", "1");
		void Precision(const Standard_Real P);
		%feature("autodoc", "1");
		Standard_Real Precision();
		%feature("autodoc", "1");
		void Plane(const Handle_Geom_Plane &P);
		%feature("autodoc", "1");
		const Handle_Geom_Plane & Plane();
		%feature("autodoc", "1");
		Standard_Boolean CheckSameRange(const TopoDS_Edge &E, const Standard_Real Confusion=9.9999999999999997988664762925561536725284350613e-13);
		%feature("autodoc", "1");
		void SameRange(const TopoDS_Edge &E, const Standard_Real Tolerance=1.00000000000000008180305391403130954586231382564e-5);
		%feature("autodoc", "1");
		Standard_Boolean BuildCurve3d(const TopoDS_Edge &E, const Standard_Real Tolerance=1.00000000000000008180305391403130954586231382564e-5, const GeomAbs_Shape Continuity=GeomAbs_C1, const Standard_Integer MaxDegree=14, const Standard_Integer MaxSegment=0);
		%feature("autodoc", "1");
		Standard_Boolean BuildCurves3d(const TopoDS_Shape &S, const Standard_Real Tolerance, const GeomAbs_Shape Continuity=GeomAbs_C1, const Standard_Integer MaxDegree=14, const Standard_Integer MaxSegment=0);
		%feature("autodoc", "1");
		Standard_Boolean BuildCurves3d(const TopoDS_Shape &S);
		%feature("autodoc", "1");
		Standard_Boolean UpdateEdgeTol(const TopoDS_Edge &E, const Standard_Real MinToleranceRequest, const Standard_Real MaxToleranceToCheck);
		%feature("autodoc", "1");
		Standard_Boolean UpdateEdgeTolerance(const TopoDS_Shape &S, const Standard_Real MinToleranceRequest, const Standard_Real MaxToleranceToCheck);
		%feature("autodoc", "1");
		void SameParameter(const TopoDS_Edge &E, const Standard_Real Tolerance=1.00000000000000008180305391403130954586231382564e-5);
		%feature("autodoc", "1");
		void SameParameter(const TopoDS_Shape &S, const Standard_Real Tolerance=1.00000000000000008180305391403130954586231382564e-5, const Standard_Boolean forced=0);
		%feature("autodoc", "1");
		void UpdateTolerances(const TopoDS_Shape &S, const Standard_Boolean verifyFaceTolerance=0);
		%feature("autodoc", "1");
		Standard_Boolean OrientClosedSolid(TopoDS_Solid & solid);
		%feature("autodoc", "1");
		void EncodeRegularity(const TopoDS_Shape &S, const Standard_Real TolAng=1.0000000000000000364321973154977415791655470656e-10);
		%feature("autodoc", "1");
		void EncodeRegularity(TopoDS_Edge & S, const TopoDS_Face &F1, const TopoDS_Face &F2, const Standard_Real TolAng=1.0000000000000000364321973154977415791655470656e-10);
		%feature("autodoc", "1");
		void SortFaces(const TopoDS_Shape &S, TopTools_ListOfShape & LF);
		%feature("autodoc", "1");
		void ReverseSortFaces(const TopoDS_Shape &S, TopTools_ListOfShape & LF);

};

%nodefaultctor BRepLib_MakePolygon;
class BRepLib_MakePolygon : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakePolygon();
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const gp_Pnt &P1, const gp_Pnt &P2);
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const gp_Pnt &P1, const gp_Pnt &P2, const gp_Pnt &P3, const Standard_Boolean Close=0);
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const gp_Pnt &P1, const gp_Pnt &P2, const gp_Pnt &P3, const gp_Pnt &P4, const Standard_Boolean Close=0);
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const TopoDS_Vertex &V1, const TopoDS_Vertex &V2);
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const TopoDS_Vertex &V3, const Standard_Boolean Close=0);
		%feature("autodoc", "1");
		BRepLib_MakePolygon(const TopoDS_Vertex &V1, const TopoDS_Vertex &V2, const TopoDS_Vertex &V3, const TopoDS_Vertex &V4, const Standard_Boolean Close=0);
		%feature("autodoc", "1");
		void Add(const gp_Pnt &P);
		%feature("autodoc", "1");
		void Add(const TopoDS_Vertex &V);
		%feature("autodoc", "1");
		Standard_Boolean Added() const;
		%feature("autodoc", "1");
		void Close();
		%feature("autodoc", "1");
		const TopoDS_Vertex & FirstVertex() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & LastVertex() const;
		%feature("autodoc", "1");
		const TopoDS_Edge & Edge() const;
		%feature("autodoc", "1");
		const TopoDS_Wire & Wire() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakePolygon();

};

%nodefaultctor BRepLib_MakeSolid;
class BRepLib_MakeSolid : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeSolid();
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_CompSolid &S);
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_Shell &S);
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_Shell &S1, const TopoDS_Shell &S2);
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_Shell &S1, const TopoDS_Shell &S2, const TopoDS_Shell &S3);
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_Solid &So);
		%feature("autodoc", "1");
		BRepLib_MakeSolid(const TopoDS_Solid &So, const TopoDS_Shell &S);
		%feature("autodoc", "1");
		void Add(const TopoDS_Shell &S);
		%feature("autodoc", "1");
		const TopoDS_Solid & Solid() const;
		%feature("autodoc", "1");
		virtual		BRepLib_ShapeModification FaceStatus(const TopoDS_Face &F) const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeSolid();

};

%nodefaultctor BRepLib_MakeFace;
class BRepLib_MakeFace : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeFace();
		%feature("autodoc", "1");
		BRepLib_MakeFace(const TopoDS_Face &F);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Pln &P);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cylinder &C);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cone &C);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Sphere &S);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Torus &C);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const Handle_Geom_Surface &S);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Pln &P, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cylinder &C, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cone &C, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Sphere &S, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Torus &C, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const Handle_Geom_Surface &S, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const TopoDS_Wire &W, const Standard_Boolean OnlyPlane=0);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Pln &P, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cylinder &C, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Cone &C, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Sphere &S, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const gp_Torus &C, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const Handle_Geom_Surface &S, const TopoDS_Wire &W, const Standard_Boolean Inside=1);
		%feature("autodoc", "1");
		BRepLib_MakeFace(const TopoDS_Face &F, const TopoDS_Wire &W);
		%feature("autodoc", "1");
		void Init(const TopoDS_Face &F);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Surface &S, const Standard_Boolean Bound=1);
		%feature("autodoc", "1");
		void Init(const Handle_Geom_Surface &S, const Standard_Real UMin, const Standard_Real UMax, const Standard_Real VMin, const Standard_Real VMax);
		%feature("autodoc", "1");
		void Add(const TopoDS_Wire &W);
		%feature("autodoc", "1");
		BRepLib_FaceError Error() const;
		%feature("autodoc", "1");
		const TopoDS_Face & Face() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeFace();

};

%nodefaultctor BRepLib_FindSurface;
class BRepLib_FindSurface {
	public:
		%feature("autodoc", "1");
		~BRepLib_FindSurface();
		%feature("autodoc", "1");
		BRepLib_FindSurface();
		%feature("autodoc", "1");
		BRepLib_FindSurface(const TopoDS_Shape &S, const Standard_Real Tol=-0x000000001, const Standard_Boolean OnlyPlane=0);
		%feature("autodoc", "1");
		void Init(const TopoDS_Shape &S, const Standard_Real Tol=-0x000000001, const Standard_Boolean OnlyPlane=0);
		%feature("autodoc", "1");
		Standard_Boolean Found() const;
		%feature("autodoc", "1");
		Handle_Geom_Surface Surface() const;
		%feature("autodoc", "1");
		Standard_Real Tolerance() const;
		%feature("autodoc", "1");
		Standard_Real ToleranceReached() const;
		%feature("autodoc", "1");
		Standard_Boolean Existed() const;
		%feature("autodoc", "1");
		TopLoc_Location Location() const;

};

%nodefaultctor BRepLib_MakeWire;
class BRepLib_MakeWire : public BRepLib_MakeShape {
	public:
		%feature("autodoc", "1");
		BRepLib_MakeWire();
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Edge &E);
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Edge &E1, const TopoDS_Edge &E2);
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Edge &E1, const TopoDS_Edge &E2, const TopoDS_Edge &E3);
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Edge &E1, const TopoDS_Edge &E2, const TopoDS_Edge &E3, const TopoDS_Edge &E4);
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Wire &W);
		%feature("autodoc", "1");
		BRepLib_MakeWire(const TopoDS_Wire &W, const TopoDS_Edge &E);
		%feature("autodoc", "1");
		void Add(const TopoDS_Edge &E);
		%feature("autodoc", "1");
		void Add(const TopoDS_Wire &W);
		%feature("autodoc", "1");
		void Add(const TopTools_ListOfShape &L);
		%feature("autodoc", "1");
		BRepLib_WireError Error() const;
		%feature("autodoc", "1");
		const TopoDS_Wire & Wire() const;
		%feature("autodoc", "1");
		const TopoDS_Edge & Edge() const;
		%feature("autodoc", "1");
		const TopoDS_Vertex & Vertex() const;
		%feature("autodoc", "1");
		virtual		~BRepLib_MakeWire();

};