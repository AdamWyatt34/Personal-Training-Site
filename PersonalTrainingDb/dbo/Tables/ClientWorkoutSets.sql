CREATE TABLE [dbo].[ClientWorkoutSets]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [SetNumber] INT NOT NULL, 
    [ClientWorkoutId] INT NOT NULL, 
    [WorkoutExerciseId] INT NOT NULL, 
    [Reps] INT NOT NULL, 
    [Weight] INT NOT NULL, 
    CONSTRAINT [FK_ClientWorkoutSets_ClientWorkouts] FOREIGN KEY ([ClientWorkoutId]) REFERENCES [ClientWorkouts]([Id]), 
    CONSTRAINT [FK_ClientWorkoutSets_WorkoutExercises] FOREIGN KEY ([WorkoutExerciseId]) REFERENCES [WorkoutExercises]([Id])
)
