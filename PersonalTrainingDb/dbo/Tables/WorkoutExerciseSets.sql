CREATE TABLE [dbo].[WorkoutExerciseSets]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [WorkoutExerciseId] INT NOT NULL,
    [SetNumber] INT NOT NULL, 
    [Reps] INT NOT NULL, 
    CONSTRAINT [FK_WorkoutExerciseSets_WorkoutExercises] FOREIGN KEY ([WorkoutExerciseId]) REFERENCES [WorkoutExercises]([Id]), 
)
