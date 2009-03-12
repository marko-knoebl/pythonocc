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

#include<BRepLProp.hxx>
#include<BRepLProp_CLProps.hxx>
#include<BRepLProp_CurveTool.hxx>
#include<BRepLProp_SLProps.hxx>
#include<BRepLProp_SurfaceTool.hxx>

// Additional headers necessary for compilation.

#include<BRepLProp.hxx>
#include<BRepLProp_CLProps.hxx>
#include<BRepLProp_CurveTool.hxx>
#include<BRepLProp_SLProps.hxx>
#include<BRepLProp_SurfaceTool.hxx>

// Needed headers necessary for compilation.

#include<BRepAdaptor_Surface.hxx>
#include<gp_Pnt.hxx>
#include<gp_Vec.hxx>
#include<gp_Dir.hxx>
#include<BRepAdaptor_Curve.hxx>
#include<BRepLProp.hxx>
%}
