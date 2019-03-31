/**
 * @description: Utility class for daily scheduled jobs
 **/
global class DailyScheduler implements Schedulable {
    /**
     * @description: Executes the schedulable class
     * @param ctx: Scheduable context variable
     **/
    global void execute(SchedulableContext ctx)
    {
        Id batchinstance_id = Database.executeBatch(new 
SurveyEmailSender());
    }
}
