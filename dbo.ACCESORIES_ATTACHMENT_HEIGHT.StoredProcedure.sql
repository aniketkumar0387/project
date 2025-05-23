USE [NXTABS]
GO
/****** Object:  StoredProcedure [dbo].[ACCESORIES_ATTACHMENT_HEIGHT]    Script Date: 5/14/2025 1:31:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ACCESORIES_ATTACHMENT_HEIGHT]  
   @BUILDINGID 
      /*
      *   **********************************************************************
      *   Procedure:			 ACCESORIES_ATTACHMENT_HEIGHT
      *   Create Date:		 02-03-2022
      *   Author:				 Sharad Savariya
      *   Description:		 Getting data of AttachInformation, AttachGeometry, ParentInformation, ParentGeometry, BaysData & SoldierColumnData
      *   Affected Tables:     BuildingInformation
      *                        GeometryInformation
      *                        Input_GirtsBaySpacing
      *                        Input_Bays
      *                        Input_GirtsBaySpacing_Wall
      *                        
      *   Parameter(s):		 BUILDINGID
      *                        OUTPUT_ATTACHINFORMATIONDATA (OUT)
      *                        OUTPUT_ATTACHGEOMETRYDATA (OUT)
      *                        OUTPUT_PARENTINFORMATIONDATA (OUT)
      *                        OUTPUT_PARENTGEOMETRYDATA (OUT)
      *                        OUTPUT_BAYSDATA (OUT)
      *                        OUTPUT_SOLDIERCOLUMNDATA (OUT)
      *                        
      *   
      *   *************************************************************************
      *   Summary Of Changes
      *   Data (YYYY-MM-DD)		Author				Comments
      *   ----------------------- ------------------- -----------------------------
      *   
      *   ************************************************************************
      */int
AS 
   BEGIN

      DECLARE
         @ATTACHCATEGORY varchar(40), 
         @PARENTCATEGORY varchar(40), 
         @PARENTBUILDINGID int, 
         @ATTACHMENTELEVATION varchar(5)

      SELECT @PARENTBUILDINGID = BuildingInformation.ParentBuildingId, @ATTACHMENTELEVATION = BuildingInformation.AttachmentElevation
      FROM dbo.BuildingInformation With(Nolock)
      WHERE BuildingInformation.BuildingInformationId = @BUILDINGID

      SELECT @ATTACHMENTELEVATION = substring(@ATTACHMENTELEVATION, 3, 1)

			 SELECT BuildingInformation.FrameType, isnull(BuildingInformation.AttachmentElevation, 'N/A') AS AttachmentElevation, BuildingInformation.Elevation, BuildingInformation.ParentBuildingId
            FROM dbo.BuildingInformation With(Nolock)
            WHERE BuildingInformation.BuildingInformationId = @BUILDINGID



      SELECT TOP 1 
			@ATTACHCATEGORY = Category
		FROM 
			dbo.GeometryInformation WITH (NOLOCK)
		WHERE 
			BuildingInformationId = @BUILDINGID

      SELECT TOP 1 
		@PARENTCATEGORY = Category
	FROM 
		dbo.GeometryInformation WITH (NOLOCK)
	WHERE 
		BuildingInformationId = @PARENTBUILDINGID

	  IF (@ATTACHCATEGORY = 'SymmetricalEndWall' OR @ATTACHCATEGORY = 'NonSymmetricalEndWall')
         BEGIN
                  SELECT TOP 1
					BuildingWidth,
					BuildingLength,
					EaveHeightSideWallB AS EaveHeightSideWallOne,
					EaveHeightSideWallD AS EaveHeightSideWallTwo,
					DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne,
					DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo,
					PeakHeight,
					StartColumn,
					StopColumn,
					XCoordinate,
					YCoordinate,
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID
         END	

      IF (@ATTACHCATEGORY = 'SymmetricalSideWall' OR @ATTACHCATEGORY = 'NonSymmetricalSideWall')
         BEGIN
                 SELECT TOP 1
					BuildingWidth,
					BuildingLength,
					EaveHeightSideWallA AS EaveHeightSideWallOne,
					EaveHeightSideWallC AS EaveHeightSideWallTwo,
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne,
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo,
					PeakHeight,
					StartColumn,
					StopColumn,
					XCoordinate,
					YCoordinate,
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID

         END

      IF (@ATTACHCATEGORY = 'SingleSlopeEndWallB' OR @ATTACHCATEGORY = 'LeanToB')
         BEGIN
                  SELECT TOP 1
					BuildingWidth,
					BuildingLength,
					EaveHeightSideWallB AS EaveHeightSideWallOne,
					EaveHeightSideWallD AS EaveHeightSideWallTwo,
					DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne,
					DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo,
					PeakHeight,
					StartColumn,
					StopColumn,
					XCoordinate,
					YCoordinate,
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID

         END

      IF (@ATTACHCATEGORY = 'SingleSlopeSideWallC' OR @ATTACHCATEGORY = 'LeanToC')
         BEGIN
                  SELECT TOP 1
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallA AS EaveHeightSideWallOne, 
					EaveHeightSideWallC AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID

         END

      IF (@ATTACHCATEGORY = 'SingleSlopeSideWallA' OR @ATTACHCATEGORY = 'LeanToA')
         BEGIN
                  SELECT TOP 1
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallA AS EaveHeightSideWallOne, 
					EaveHeightSideWallC AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID

         END

      IF (@ATTACHCATEGORY = 'SingleSlopeEndWallD' OR @ATTACHCATEGORY = 'LeanToD')
         BEGIN
                  SELECT TOP 1
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallB AS EaveHeightSideWallOne, 
					EaveHeightSideWallD AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @BUILDINGID

         END

		 	 SELECT BuildingInformation.FrameType, isnull(BuildingInformation.AttachmentElevation, 'N/A') AS AttachmentElevation, BuildingInformation.Elevation, BuildingInformation.ParentBuildingId
            FROM dbo.BuildingInformation With(Nolock)
            WHERE BuildingInformation.BuildingInformationId = @PARENTBUILDINGID

      IF (@PARENTCATEGORY = 'SymmetricalEndWall' OR @PARENTCATEGORY = 'NonSymmetricalEndWall')
         BEGIN
                  SELECT TOP 1
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallB AS EaveHeightSideWallOne, 
					EaveHeightSideWallD AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @PARENTBUILDINGID
         END

      IF (@PARENTCATEGORY = 'SymmetricalSideWall' OR @PARENTCATEGORY = 'NonSymmetricalSideWall')
         BEGIN
                  SELECT TOP 1
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallA AS EaveHeightSideWallOne, 
					EaveHeightSideWallC AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @PARENTBUILDINGID;
         END

      IF (@PARENTCATEGORY = 'SingleSlopeEndWallB' OR @PARENTCATEGORY = 'LeanToB')
         BEGIN
                  SELECT TOP 1 
						BuildingWidth, 
						BuildingLength, 
						EaveHeightSideWallB AS EaveHeightSideWallOne, 
						EaveHeightSideWallD AS EaveHeightSideWallTwo, 
						DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne, 
						DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo, 
						PeakHeight, 
						StartColumn, 
						StopColumn, 
						XCoordinate, 
						YCoordinate, 
						AttachmentOffset
					FROM 
						dbo.GeometryInformation WITH (NOLOCK)
					WHERE 
						BuildingInformationId = @PARENTBUILDINGID;
         END

      IF (@PARENTCATEGORY = 'SingleSlopeSideWallC' OR @PARENTCATEGORY = 'LeanToC')
         BEGIN

                  SELECT TOP 1 
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallA AS EaveHeightSideWallOne, 
					EaveHeightSideWallC AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @PARENTBUILDINGID;
         END

      IF (@PARENTCATEGORY = 'SingleSlopeSideWallA' OR @PARENTCATEGORY = 'LeanToA')
         BEGIN

                  SELECT TOP 1 
					BuildingWidth, 
					BuildingLength, 
					EaveHeightSideWallA AS EaveHeightSideWallOne, 
					EaveHeightSideWallC AS EaveHeightSideWallTwo, 
					DistanceToRidgeSideWallA AS DistanceToRidgeSideWallOne, 
					DistanceToRidgeSideWallC AS DistanceToRidgeSideWallTwo, 
					PeakHeight, 
					StartColumn, 
					StopColumn, 
					XCoordinate, 
					YCoordinate, 
					AttachmentOffset
				FROM 
					dbo.GeometryInformation WITH (NOLOCK)
				WHERE 
					BuildingInformationId = @PARENTBUILDINGID;
         END

      IF (@PARENTCATEGORY = 'SingleSlopeEndWallD' OR @PARENTCATEGORY = 'LeanToD')
         BEGIN

                  SELECT 
                     GeometryInformation.BuildingWidth, 
                     GeometryInformation.BuildingLength, 
                     GeometryInformation.EaveHeightSideWallB AS EaveHeightSideWallOne, 
                     GeometryInformation.EaveHeightSideWallD AS EaveHeightSideWallTwo, 
                     GeometryInformation.DistanceToRidgeSideWallB AS DistanceToRidgeSideWallOne, 
                     GeometryInformation.DistanceToRidgeSideWallD AS DistanceToRidgeSideWallTwo, 
                     GeometryInformation.PeakHeight, 
                     GeometryInformation.StartColumn, 
                     GeometryInformation.StopColumn, 
                     GeometryInformation.XCoordinate, 
                     GeometryInformation.YCoordinate, 
                     GeometryInformation.AttachmentOffset
                  FROM dbo.GeometryInformation With(Nolock)
                  WHERE GeometryInformation.BuildingInformationId = @PARENTBUILDINGID
         END
		 SELECT Input_Bays.Width AS BayWidth, Input_Bays.BayNumber
            FROM dbo.Input_Bays With(Nolock)
            WHERE Input_Bays.BuildingInformationId = @PARENTBUILDINGID AND Input_Bays.Elevation = @ATTACHMENTELEVATION

 
            SELECT Input_GirtsBaySpacing_Wall.DistFromLeftColumn, Input_GirtsBaySpacing_Wall.RoofBayNumber
            FROM dbo.Input_GirtsBaySpacing_Wall With(Nolock)
			JOIN dbo.Input_GirtsBaySpacing With(Nolock)
				ON Input_GirtsBaySpacing_Wall.GirtSpacingId = Input_GirtsBaySpacing.GirtSpacingId
            WHERE Input_GirtsBaySpacing.BuildingInformationId = @PARENTBUILDINGID
                AND Input_GirtsBaySpacing_Wall.Elevation = @ATTACHMENTELEVATION

   END
GO
