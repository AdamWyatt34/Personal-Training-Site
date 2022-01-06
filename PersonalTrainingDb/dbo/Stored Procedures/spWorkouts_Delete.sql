CREATE PROCEDURE [dbo].[spWorkouts_Delete]
	@Id int
AS


begin

	set nocount on;

	DELETE FROM Workouts
	WHERE Id = @Id

end
