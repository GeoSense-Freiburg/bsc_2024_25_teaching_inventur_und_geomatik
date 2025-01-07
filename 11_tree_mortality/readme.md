# Lecture: Tree mortality mapping with remote sensing and deadtrees.earth

## contents:
* Relevanceoftreemortalitymapping
* Towards of global tree mortality mapping
* The platform deadtrees.earth
* Recent findings



# Exercise: deadtrees pt. 1: UAV-based detection of deadwood using AI-based pattern recognition

## Aim
* Students will assess AI-based segmentation performance
* Manual labels will be compared to segmentation models of deadtrees.earth
* Students get an idea of how cumbersome labeling can be and how valuable data is
* Students will have the chance to contribute to deadtrees.earth with their labels

## Procedure
* Orthoimages will be provided to the students, who can select an orthoimage of their choice
* Example labels are available to calibrate the level of detail and quality of the labeling processing
    * https://deadtrees.earth/dataset/2412
    * https://deadtrees.earth/dataset/2364
    * https://deadtrees.earth/dataset/2944
    * https://deadtrees.earth/dataset/2486
* Students will receive a dummy label file (*.gpkg) according to deadtrees.earth standards
* Students will label orthoimages and document the progress.
* Students will compare their labels to AI-based segmentation results
* Visually in QGIS
* In R (Quarto) using script **label_comaprison_v1.qmd**
  * Plot the two shapefiles
  * Calculate the mutual area, Precision, Recall, F1 Score
* Students can then refine their polygons in case the AI was better ;-)

The entire workflow and access to data is described [here](https://docs.google.com/document/d/1jAUPqFv-Lqt3HuDDTr2yn83B8NAxivnjkVUuUlwTGA8/edit?tab=t.0#heading=h.3lsolpilbhs4)
