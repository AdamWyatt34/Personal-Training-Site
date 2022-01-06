CREATE PROCEDURE [dbo].[spWorkouts_GetById]
	@Id int
AS


SELECT [Id], [Title], [Description] FROM Workouts
WHERE Id = @Id

