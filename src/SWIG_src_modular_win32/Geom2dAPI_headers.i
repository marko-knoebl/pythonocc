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
%{

// Headers necessary to define wrapped classes.

#include<Geom2dAPI_ExtremaCurveCurve.hxx>
#include<Geom2dAPI_InterCurveCurve.hxx>
#include<Geom2dAPI_Interpolate.hxx>
#include<Geom2dAPI_PointsToBSpline.hxx>
#include<Geom2dAPI_ProjectPointOnCurve.hxx>

// Additional headers necessary for compilation.

#include<Geom2dAPI_ExtremaCurveCurve.hxx>
#include<Geom2dAPI_InterCurveCurve.hxx>
#include<Geom2dAPI_Interpolate.hxx>
#include<Geom2dAPI_PointsToBSpline.hxx>
#include<Geom2dAPI_ProjectPointOnCurve.hxx>

// Needed headers necessary for compilation.

#include<Handle_Geom2d_Curve.hxx>
#include<gp_Pnt2d.hxx>
#include<TColgp_Array1OfPnt2d.hxx>
#include<TColStd_Array1OfReal.hxx>
#include<Handle_TColgp_HArray1OfPnt2d.hxx>
#include<Handle_TColStd_HArray1OfReal.hxx>
#include<gp_Vec2d.hxx>
#include<TColgp_Array1OfVec2d.hxx>
#include<Handle_TColStd_HArray1OfBoolean.hxx>
%}
