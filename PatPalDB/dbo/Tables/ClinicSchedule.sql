CREATE TABLE [dbo].[ClinicSchedule] (
    [ScheduleId] INT           IDENTITY (1, 1) NOT NULL,
    [ClinicId]   INT           NOT NULL,
    [DayOfWeek]  NVARCHAR (10) NOT NULL,
    [StartTime]  TIME (7)      NOT NULL,
    [EndTime]    TIME (7)      NOT NULL,
    PRIMARY KEY CLUSTERED ([ScheduleId] ASC),
    CHECK ([DayOfWeek]='Sunday' OR [DayOfWeek]='Saturday' OR [DayOfWeek]='Friday' OR [DayOfWeek]='Thursday' OR [DayOfWeek]='Wednesday' OR [DayOfWeek]='Tuesday' OR [DayOfWeek]='Monday')
);

