CREATE PROCEDURE [dbo].[spWorkouts_Update]
	@Id int,
	@Title nvarchar(50),
	@Description nvarchar(250)
AS


begin

	set nocount on;

	UPDATE Workouts
	SET Title = @Title,
	[Description] = @Description
	WHERE Id = @Id

end
