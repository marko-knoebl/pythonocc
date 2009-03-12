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

#include<Handle_StepData_DefaultGeneral.hxx>
#include<Handle_StepData_DescrGeneral.hxx>
#include<Handle_StepData_DescrProtocol.hxx>
#include<Handle_StepData_DescrReadWrite.hxx>
#include<Handle_StepData_Described.hxx>
#include<Handle_StepData_ECDescr.hxx>
#include<Handle_StepData_EDescr.hxx>
#include<Handle_StepData_ESDescr.hxx>
#include<Handle_StepData_FileProtocol.hxx>
#include<Handle_StepData_FileRecognizer.hxx>
#include<Handle_StepData_FreeFormEntity.hxx>
#include<Handle_StepData_GeneralModule.hxx>
#include<Handle_StepData_GlobalNodeOfWriterLib.hxx>
#include<Handle_StepData_HArray1OfField.hxx>
#include<Handle_StepData_NodeOfWriterLib.hxx>
#include<Handle_StepData_PDescr.hxx>
#include<Handle_StepData_Plex.hxx>
#include<Handle_StepData_Protocol.hxx>
#include<Handle_StepData_ReadWriteModule.hxx>
#include<Handle_StepData_SelectArrReal.hxx>
#include<Handle_StepData_SelectInt.hxx>
#include<Handle_StepData_SelectMember.hxx>
#include<Handle_StepData_SelectNamed.hxx>
#include<Handle_StepData_SelectReal.hxx>
#include<Handle_StepData_Simple.hxx>
#include<Handle_StepData_StepModel.hxx>
#include<Handle_StepData_StepReaderData.hxx>
#include<Handle_StepData_UndefinedEntity.hxx>
#include<StepData.hxx>
#include<StepData_Array1OfField.hxx>
#include<StepData_DefaultGeneral.hxx>
#include<StepData_DescrGeneral.hxx>
#include<StepData_DescrProtocol.hxx>
#include<StepData_DescrReadWrite.hxx>
#include<StepData_Described.hxx>
#include<StepData_ECDescr.hxx>
#include<StepData_EDescr.hxx>
#include<StepData_ESDescr.hxx>
#include<StepData_EnumTool.hxx>
#include<StepData_Field.hxx>
#include<StepData_FieldList.hxx>
#include<StepData_FieldList1.hxx>
#include<StepData_FieldListD.hxx>
#include<StepData_FieldListN.hxx>
#include<StepData_FileProtocol.hxx>
#include<StepData_FileRecognizer.hxx>
#include<StepData_FreeFormEntity.hxx>
#include<StepData_GeneralModule.hxx>
#include<StepData_GlobalNodeOfWriterLib.hxx>
#include<StepData_HArray1OfField.hxx>
#include<StepData_HeaderTool.hxx>
#include<StepData_Logical.hxx>
#include<StepData_NodeOfWriterLib.hxx>
#include<StepData_PDescr.hxx>
#include<StepData_Plex.hxx>
#include<StepData_Protocol.hxx>
#include<StepData_ReadWriteModule.hxx>
#include<StepData_SelectArrReal.hxx>
#include<StepData_SelectInt.hxx>
#include<StepData_SelectMember.hxx>
#include<StepData_SelectNamed.hxx>
#include<StepData_SelectReal.hxx>
#include<StepData_SelectType.hxx>
#include<StepData_Simple.hxx>
#include<StepData_StepDumper.hxx>
#include<StepData_StepModel.hxx>
#include<StepData_StepReaderData.hxx>
#include<StepData_StepReaderTool.hxx>
#include<StepData_StepWriter.hxx>
#include<StepData_UndefinedEntity.hxx>
#include<StepData_WriterLib.hxx>

// Additional headers necessary for compilation.

#include<IGESGeom.hxx>
#include<IGESGeom_Array1OfBoundary.hxx>
#include<IGESGeom_Array1OfCurveOnSurface.hxx>
#include<IGESGeom_Array1OfTransformationMatrix.hxx>
#include<IGESGeom_BSplineCurve.hxx>
#include<IGESGeom_BSplineSurface.hxx>
#include<IGESGeom_Boundary.hxx>
#include<IGESGeom_BoundedSurface.hxx>
#include<IGESGeom_CircularArc.hxx>
#include<IGESGeom_CompositeCurve.hxx>
#include<IGESGeom_ConicArc.hxx>
#include<IGESGeom_CopiousData.hxx>
#include<IGESGeom_CurveOnSurface.hxx>
#include<IGESGeom_Direction.hxx>
#include<IGESGeom_Flash.hxx>
#include<IGESGeom_GeneralModule.hxx>
#include<IGESGeom_HArray1OfBoundary.hxx>
#include<IGESGeom_HArray1OfCurveOnSurface.hxx>
#include<IGESGeom_HArray1OfTransformationMatrix.hxx>
#include<IGESGeom_Line.hxx>
#include<IGESGeom_OffsetCurve.hxx>
#include<IGESGeom_OffsetSurface.hxx>
#include<IGESGeom_Plane.hxx>
#include<IGESGeom_Point.hxx>
#include<IGESGeom_Protocol.hxx>
#include<IGESGeom_ReadWriteModule.hxx>
#include<IGESGeom_RuledSurface.hxx>
#include<IGESGeom_SpecificModule.hxx>
#include<IGESGeom_SplineCurve.hxx>
#include<IGESGeom_SplineSurface.hxx>
#include<IGESGeom_SurfaceOfRevolution.hxx>
#include<IGESGeom_TabulatedCylinder.hxx>
#include<IGESGeom_ToolBSplineCurve.hxx>
#include<IGESGeom_ToolBSplineSurface.hxx>
#include<IGESGeom_ToolBoundary.hxx>
#include<IGESGeom_ToolBoundedSurface.hxx>
#include<IGESGeom_ToolCircularArc.hxx>
#include<IGESGeom_ToolCompositeCurve.hxx>
#include<IGESGeom_ToolConicArc.hxx>
#include<IGESGeom_ToolCopiousData.hxx>
#include<IGESGeom_ToolCurveOnSurface.hxx>
#include<IGESGeom_ToolDirection.hxx>
#include<IGESGeom_ToolFlash.hxx>
#include<IGESGeom_ToolLine.hxx>
#include<IGESGeom_ToolOffsetCurve.hxx>
#include<IGESGeom_ToolOffsetSurface.hxx>
#include<IGESGeom_ToolPlane.hxx>
#include<IGESGeom_ToolPoint.hxx>
#include<IGESGeom_ToolRuledSurface.hxx>
#include<IGESGeom_ToolSplineCurve.hxx>
#include<IGESGeom_ToolSplineSurface.hxx>
#include<IGESGeom_ToolSurfaceOfRevolution.hxx>
#include<IGESGeom_ToolTabulatedCylinder.hxx>
#include<IGESGeom_ToolTransformationMatrix.hxx>
#include<IGESGeom_ToolTrimmedSurface.hxx>
#include<IGESGeom_TransformationMatrix.hxx>
#include<IGESGeom_TrimmedSurface.hxx>
#include<IGESGraph.hxx>
#include<IGESGraph_Array1OfColor.hxx>
#include<IGESGraph_Array1OfTextDisplayTemplate.hxx>
#include<IGESGraph_Array1OfTextFontDef.hxx>
#include<IGESGraph_Color.hxx>
#include<IGESGraph_DefinitionLevel.hxx>
#include<IGESGraph_DrawingSize.hxx>
#include<IGESGraph_DrawingUnits.hxx>
#include<IGESGraph_GeneralModule.hxx>
#include<IGESGraph_HArray1OfColor.hxx>
#include<IGESGraph_HArray1OfTextDisplayTemplate.hxx>
#include<IGESGraph_HArray1OfTextFontDef.hxx>
#include<IGESGraph_HighLight.hxx>
#include<IGESGraph_IntercharacterSpacing.hxx>
#include<IGESGraph_LineFontDefPattern.hxx>
#include<IGESGraph_LineFontDefTemplate.hxx>
#include<IGESGraph_LineFontPredefined.hxx>
#include<IGESGraph_NominalSize.hxx>
#include<IGESGraph_Pick.hxx>
#include<IGESGraph_Protocol.hxx>
#include<IGESGraph_ReadWriteModule.hxx>
#include<IGESGraph_SpecificModule.hxx>
#include<IGESGraph_TextDisplayTemplate.hxx>
#include<IGESGraph_TextFontDef.hxx>
#include<IGESGraph_ToolColor.hxx>
#include<IGESGraph_ToolDefinitionLevel.hxx>
#include<IGESGraph_ToolDrawingSize.hxx>
#include<IGESGraph_ToolDrawingUnits.hxx>
#include<IGESGraph_ToolHighLight.hxx>
#include<IGESGraph_ToolIntercharacterSpacing.hxx>
#include<IGESGraph_ToolLineFontDefPattern.hxx>
#include<IGESGraph_ToolLineFontDefTemplate.hxx>
#include<IGESGraph_ToolLineFontPredefined.hxx>
#include<IGESGraph_ToolNominalSize.hxx>
#include<IGESGraph_ToolPick.hxx>
#include<IGESGraph_ToolTextDisplayTemplate.hxx>
#include<IGESGraph_ToolTextFontDef.hxx>
#include<IGESGraph_ToolUniformRectGrid.hxx>
#include<IGESGraph_UniformRectGrid.hxx>
#include<InterfaceGraphic_Aspect.hxx>
#include<InterfaceGraphic_Cextern.hxx>
#include<InterfaceGraphic_Graphic3d.hxx>
#include<InterfaceGraphic_Labels.hxx>
#include<InterfaceGraphic_Portability.hxx>
#include<InterfaceGraphic_PrimitiveArray.hxx>
#include<InterfaceGraphic_Visual3d.hxx>
#include<InterfaceGraphic_WNT.hxx>
#include<Interface_Array1OfFileParameter.hxx>
#include<Interface_Array1OfHAsciiString.hxx>
#include<Interface_BitMap.hxx>
#include<Interface_Category.hxx>
#include<Interface_Check.hxx>
#include<Interface_CheckFailure.hxx>
#include<Interface_CheckIterator.hxx>
#include<Interface_CheckStatus.hxx>
#include<Interface_CheckTool.hxx>
#include<Interface_CopyControl.hxx>
#include<Interface_CopyMap.hxx>
#include<Interface_CopyTool.hxx>
#include<Interface_DataMapIteratorOfDataMapOfIntegerTransient.hxx>
#include<Interface_DataMapIteratorOfDataMapOfTransientInteger.hxx>
#include<Interface_DataMapNodeOfDataMapOfIntegerTransient.hxx>
#include<Interface_DataMapNodeOfDataMapOfTransientInteger.hxx>
#include<Interface_DataMapOfIntegerTransient.hxx>
#include<Interface_DataMapOfTransientInteger.hxx>
#include<Interface_DataState.hxx>
#include<Interface_EntityCluster.hxx>
#include<Interface_EntityIterator.hxx>
#include<Interface_EntityList.hxx>
#include<Interface_FileParameter.hxx>
#include<Interface_FileReaderData.hxx>
#include<Interface_FileReaderTool.hxx>
#include<Interface_FloatWriter.hxx>
#include<Interface_GTool.hxx>
#include<Interface_GeneralLib.hxx>
#include<Interface_GeneralModule.hxx>
#include<Interface_GlobalNodeOfGeneralLib.hxx>
#include<Interface_GlobalNodeOfReaderLib.hxx>
#include<Interface_Graph.hxx>
#include<Interface_GraphContent.hxx>
#include<Interface_HArray1OfHAsciiString.hxx>
#include<Interface_HGraph.hxx>
#include<Interface_HSequenceOfCheck.hxx>
#include<Interface_IndexedMapNodeOfIndexedMapOfAsciiString.hxx>
#include<Interface_IndexedMapOfAsciiString.hxx>
#include<Interface_IntList.hxx>
#include<Interface_IntVal.hxx>
#include<Interface_InterfaceError.hxx>
#include<Interface_InterfaceMismatch.hxx>
#include<Interface_InterfaceModel.hxx>
#include<Interface_LineBuffer.hxx>
#include<Interface_MSG.hxx>
#include<Interface_Macros.hxx>
#include<Interface_MapAsciiStringHasher.hxx>
#include<Interface_NodeOfGeneralLib.hxx>
#include<Interface_NodeOfReaderLib.hxx>
#include<Interface_ParamList.hxx>
#include<Interface_ParamSet.hxx>
#include<Interface_ParamType.hxx>
#include<Interface_Protocol.hxx>
#include<Interface_ReaderLib.hxx>
#include<Interface_ReaderModule.hxx>
#include<Interface_ReportEntity.hxx>
#include<Interface_STAT.hxx>
#include<Interface_SequenceNodeOfSequenceOfCheck.hxx>
#include<Interface_SequenceOfCheck.hxx>
#include<Interface_ShareFlags.hxx>
#include<Interface_ShareTool.hxx>
#include<Interface_SignLabel.hxx>
#include<Interface_SignType.hxx>
#include<Interface_Static.hxx>
#include<Interface_StaticSatisfies.hxx>
#include<Interface_Statics.hxx>
#include<Interface_Translates.hxx>
#include<Interface_TypedValue.hxx>
#include<Interface_UndefinedContent.hxx>
#include<Interface_ValueInterpret.hxx>
#include<Interface_ValueSatisfies.hxx>
#include<Interface_VectorOfFileParameter.hxx>
#include<Interface_Version.hxx>
#include<MoniTool_AttrList.hxx>
#include<MoniTool_CaseData.hxx>
#include<MoniTool_DataInfo.hxx>
#include<MoniTool_DataMapIteratorOfDataMapOfShapeTransient.hxx>
#include<MoniTool_DataMapIteratorOfDataMapOfTimer.hxx>
#include<MoniTool_DataMapNodeOfDataMapOfShapeTransient.hxx>
#include<MoniTool_DataMapNodeOfDataMapOfTimer.hxx>
#include<MoniTool_DataMapOfShapeTransient.hxx>
#include<MoniTool_DataMapOfTimer.hxx>
#include<MoniTool_ElemHasher.hxx>
#include<MoniTool_Element.hxx>
#include<MoniTool_HSequenceOfElement.hxx>
#include<MoniTool_IndexedDataMapNodeOfIndexedDataMapOfShapeTransient.hxx>
#include<MoniTool_IndexedDataMapOfShapeTransient.hxx>
#include<MoniTool_IntVal.hxx>
#include<MoniTool_MTHasher.hxx>
#include<MoniTool_Macros.hxx>
#include<MoniTool_OptValue.hxx>
#include<MoniTool_Option.hxx>
#include<MoniTool_Profile.hxx>
#include<MoniTool_RealVal.hxx>
#include<MoniTool_SequenceNodeOfSequenceOfElement.hxx>
#include<MoniTool_SequenceOfElement.hxx>
#include<MoniTool_SignShape.hxx>
#include<MoniTool_SignText.hxx>
#include<MoniTool_Stat.hxx>
#include<MoniTool_Timer.hxx>
#include<MoniTool_TimerSentry.hxx>
#include<MoniTool_TransientElem.hxx>
#include<MoniTool_TypedValue.hxx>
#include<MoniTool_ValueInterpret.hxx>
#include<MoniTool_ValueSatisfies.hxx>
#include<MoniTool_ValueType.hxx>
#include<TCollection.hxx>
#include<TCollection_AVLBaseNode.hxx>
#include<TCollection_AVLBaseNodePtr.hxx>
#include<TCollection_Array1Descriptor.hxx>
#include<TCollection_Array2Descriptor.hxx>
#include<TCollection_AsciiString.hxx>
#include<TCollection_BaseSequence.hxx>
#include<TCollection_BasicMap.hxx>
#include<TCollection_BasicMapIterator.hxx>
#include<TCollection_CompareOfInteger.hxx>
#include<TCollection_CompareOfReal.hxx>
#include<TCollection_ExtendedString.hxx>
#include<TCollection_HAsciiString.hxx>
#include<TCollection_HExtendedString.hxx>
#include<TCollection_MapNode.hxx>
#include<TCollection_MapNodePtr.hxx>
#include<TCollection_PrivCompareOfInteger.hxx>
#include<TCollection_PrivCompareOfReal.hxx>
#include<TCollection_SeqNode.hxx>
#include<TCollection_SeqNodePtr.hxx>
#include<TCollection_Side.hxx>

// Needed headers necessary for compilation.

#include<Handle_Standard_Transient.hxx>
#include<Handle_TColStd_HSequenceOfAsciiString.hxx>
#include<Handle_Message_Messenger.hxx>
#include<Handle_Interface_Protocol.hxx>
#include<Handle_Standard_Type.hxx>
#include<Interface_Graph.hxx>
#include<Handle_Interface_Check.hxx>
#include<Handle_Interface_InterfaceModel.hxx>
#include<Interface_EntityIterator.hxx>
#include<Handle_TCollection_HAsciiString.hxx>
#include<TCollection_AsciiString.hxx>
#include<Handle_Interface_FileReaderData.hxx>
#include<TColStd_SequenceOfAsciiString.hxx>
#include<Interface_ShareTool.hxx>
#include<Interface_CopyTool.hxx>
#include<StepData.hxx>
#include<Handle_TColStd_HArray1OfReal.hxx>
#include<Interface_CheckIterator.hxx>
#include<Handle_Interface_UndefinedContent.hxx>
%}
