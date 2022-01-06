CREATE TABLE [dbo].[WorkoutExercises]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [WorkoutId] INT NOT NULL, 
    [ExerciseId] INT NOT NULL, 
    [Notes] NVARCHAR(250) NULL, 
    CONSTRAINT [FK_WorkoutExercises_Exercises] FOREIGN KEY (ExerciseId) REFERENCES [Exercises]([Id]), 
    CONSTRAINT [FK_WorkoutExercises_Workouts] FOREIGN KEY ([WorkoutId]) REFERENCES [Workouts]([Id])
)
