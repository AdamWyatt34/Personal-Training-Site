CREATE PROCEDURE [dbo].[spWorkouts_Create]
	@Title nvarchar(50),
	@Description nvarchar(250),
	@Id int output
AS
	
begin

	set nocount on;

	INSERT INTO Workouts(Title, [Description])
	Values(@Title, @Description)

	SET @Id = SCOPE_IDENTITY();

end
