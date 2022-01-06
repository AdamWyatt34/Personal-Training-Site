/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

If not exists(SELECT 1 FROM dbo.Exercises)
begin
    INSERT INTO Exercises([Name], [Description])
    Values('Barbell Bench Press','Lie back on a flat bench. Using a medium width grip (a grip that creates a 90-degree angle in the middle of the movement between the forearms and the upper arms), lift the bar from the rack and hold it straight over you with your arms locked. This will be your starting position.
                From the starting position, breathe in and begin coming down slowly until the bar touches your middle chest.
                After a brief pause, push the bar back to the starting position as you breathe out. Focus on pushing the bar using your chest muscles. Lock your arms and squeeze your chest in the contracted position at the top of the motion, hold for a second and then start coming down slowly again. Tip: Ideally, lowering the weight should take about twice as long as raising it.
                Repeat the movement for the prescribed amount of repetitions.
                When you are done, place the bar back in the rack'),
           ('Barbell Bent Over Row','Holding a barbell with a pronated grip (palms facing down), bend your knees slightly and bring your torso forward, by bending at the waist, while keeping the back straight until it is almost parallel to the floor. Tip: Make sure that you keep the head up. The barbell should hang directly in front of you as your arms hang perpendicular to the floor and your torso. This is your starting position.
                Now, while keeping the torso stationary, breathe out and lift the barbell to you. Keep the elbows close to the body and only use the forearms to hold the weight. At the top contracted position, squeeze the back muscles and hold for a brief pause.
                Then inhale and slowly lower the barbell back to the starting position.
                Repeat for the recommended amount of repetitions.'),
           ('Barbell Squat','Begin with the barbell supported on top of the traps. The chest should be up and the head facing forward. Adopt a hip-width stance with the feet turned out as needed.
                Descend by flexing the knees, refraining from moving the hips back as much as possible. This requires that the knees travel forward. Ensure that they stay align with the feet. The goal is to keep the torso as upright as possible.
                Continue all the way down, keeping the weight on the front of the heel. At the moment the upper legs contact the lower legs reverse the motion, driving the weight upward.')
end

if not exists(SELECT 1 FROM dbo.Clients)
begin
    INSERT INTO Clients(FirstName, LastName, EmailAddress, PhoneNumber, DateOfBirth)
    Values('Adam', 'Wyatt', 'adamrwyatt1@gmail.com', '863-286-2156', '6/1/1995'),
          ('Lacey', 'Wyatt', 'lacey@atomtraining.com', '863-555-1212', '2/1/1993')
end

if not exists(SELECT 1 FROM dbo.Workouts)
begin
    INSERT INTO Workouts(Title, [Description])
    Values('Chest and Back', 'Sample Chest and Back Workout'),
    ('Back and Legs', 'Sample Back and Legs Workout'),
    ('Chest and Legs','Sample Chest and Legs Workout')
end

if not exists (SELECT 1 FROM dbo.WorkoutExercises)
begin
    declare @exerciseId1 int;
    declare @exerciseId2 int;
    declare @exerciseId3 int;

    select @exerciseId1 = Id FROM dbo.Exercises WHERE [Name] = 'Barbell Bench Press'
    select @exerciseId2 = Id FROM dbo.Exercises WHERE [Name] = 'Barbell Bent Over Row'
    select @exerciseId3 = Id FROM dbo.Exercises WHERE [Name] = 'Barbell Squat'

    declare @workoutId1 int;
    declare @workoutId2 int;
    declare @workoutId3 int;

    select @workoutId1 = Id FROM dbo.Workouts WHERE Title = 'Chest and Back'
    select @workoutId2 = Id FROM dbo.Workouts WHERE Title = 'Back and Legs'
    select @workoutId3 = Id FROM dbo.Workouts WHERE Title = 'Chest and Legs'

    INSERT INTO dbo.WorkoutExercises(ExerciseId, WorkoutId, Notes)
    Values(@exerciseId1, @workoutId1, '1st exercise'),
    (@exerciseId2, @workoutId1, '2nd exercise'),
    (@exerciseId2, @workoutId2, '3rd exercise'),
    (@exerciseId3, @workoutId2, '4th exercise'),
    (@exerciseId1, @workoutId3, '5th exercise'),
    (@exerciseId3, @workoutId3, '6th exercise')
end

if not exists (SELECT 1 FROM dbo.WorkoutExerciseSets)
begin
    declare @workoutExerciseId1 int;
    declare @workoutExerciseId2 int;
    declare @workoutExerciseId3 int;
    declare @workoutExerciseId4 int;
    declare @workoutExerciseId5 int;
    declare @workoutExerciseId6 int;

    select @workoutExerciseId1 = Id FROM dbo.WorkoutExercises WHERE Notes = '1st exercise'
    select @workoutExerciseId2 = Id FROM dbo.WorkoutExercises WHERE Notes = '2nd exercise'
    select @workoutExerciseId3 = Id FROM dbo.WorkoutExercises WHERE Notes = '3rd exercise'
    select @workoutExerciseId4 = Id FROM dbo.WorkoutExercises WHERE Notes = '4th exercise'
    select @workoutExerciseId5 = Id FROM dbo.WorkoutExercises WHERE Notes = '5th exercise'
    select @workoutExerciseId6 = Id FROM dbo.WorkoutExercises WHERE Notes = '6th exercise'
   
    INSERT INTO dbo.WorkoutExerciseSets(WorkoutExerciseId, SetNumber, Reps)
    values(@workoutExerciseId1, 1, 10),
    (@workoutExerciseId1, 2, 10),
    (@workoutExerciseId1, 3, 15),
    (@workoutExerciseId2, 1, 8),
    (@workoutExerciseId2, 2, 10),
    (@workoutExerciseId3, 1, 10),
    (@workoutExerciseId3, 2, 10),
    (@workoutExerciseId3, 3, 8),
    (@workoutExerciseId4, 1, 10),
    (@workoutExerciseId5, 1, 10),
    (@workoutExerciseId5, 2, 12),
    (@workoutExerciseId6, 1, 15),
    (@workoutExerciseId6, 2, 20)
end

if not exists (Select 1 FROM ClientWorkouts)
begin
    declare @clientId1 int;
    declare @clientId2 int;

    select @clientId1 = Id FROM dbo.Clients WHERE FirstName = 'Adam'
    select @clientId2 = Id FROM dbo.Clients WHERE FirstName = 'Lacey'

    select @workoutId1 = Id FROM dbo.Workouts WHERE Title = 'Chest and Back'
    select @workoutId2 = Id FROM dbo.Workouts WHERE Title = 'Back and Legs'
    select @workoutId3 = Id FROM dbo.Workouts WHERE Title = 'Chest and Legs'

    INSERT INTO dbo.ClientWorkouts(ClientId, WorkoutId, DateScheduledFor)
    Values(@clientId1,@workoutId1,'1/10/2022'),
    (@clientId1, @workoutId2, '1/11/2022'),
    (@clientId1, @workoutId1, '1/12/2022'),
    (@clientId2, @workoutId3, '1/10/2022'),
    (@clientId2, @workoutId2, '1/12/2022')

end

