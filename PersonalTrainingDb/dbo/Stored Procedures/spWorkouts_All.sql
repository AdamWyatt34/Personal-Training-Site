CREATE PROCEDURE [dbo].[spWorkouts_All]
	
AS

begin

	set nocount on;

	SELECT [Id], [Title], [Description] FROM Workouts

end
