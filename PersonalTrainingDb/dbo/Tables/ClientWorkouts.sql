CREATE TABLE [dbo].[ClientWorkouts]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [ClientId] INT NOT NULL, 
    [WorkoutId] INT NOT NULL, 
    [DateScheduledFor] DATETIME2 NOT NULL, 
    [DateCompleted] DATETIME2 NULL, 
    CONSTRAINT [FK_ClientWorkouts_Clients] FOREIGN KEY ([ClientId]) REFERENCES [Clients]([Id]), 
    CONSTRAINT [FK_ClientWorkouts_Workouts] FOREIGN KEY ([WorkoutID]) REFERENCES [Workouts]([Id])
)
