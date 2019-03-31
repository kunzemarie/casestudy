/**
 * @description: SurveyEmailSender to send mass emails
 **/
global class SurveyEmailSender implements Database.Batchable<sObject> {

    // Classic Email Template IDs
    static String email_template_en = 'XXX';
    static String email_template_de = 'XXX';
    
    // Language strings
    static String lang_de = 'de';
    static String lang_en = 'en';
    
    /**
     * @description: BatchJob start method to query contacts with survey 
   date before today
     * @param BC: Batchable contect
     **/
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id, survey_date__c, language__c FROM 
  Contact WHERE survey_date__c <= TODAY';
        return Database.getQueryLocator(query);
    }
    
    /**
     * @description: Execute BatchJob
     * @param BC: Batchable contect
     * @param contacts: sObjects returned by batch query
     **/
    global void execute(Database.BatchableContext BC, List<sObject> contacts) {
		// Survey email lists
        List <ID> 	contacts_en = new list<ID>(), 
        			contacts_de = new list<ID>();
        
        Contact contactRecord;
        for (sObject c : contacts) {
            contactRecord = (Contact) c;
            
            // Retrieve contact language and add to email ist
            if(contactRecord.language__c == lang_de) {
                contacts_de.add(contactRecord.Id);
            } else if(contactRecord.language__c == lang_en) {
                contacts_en.add(contactRecord.Id);
            }
            
            // Clear survey date field
            contactRecord.survey_date__c = null;
        }
        update contacts;
        
        sendMassEmail(email_template_de, contacts_de);
        sendMassEmail(email_template_en, contacts_en);
        
    }
    
    /**
     * @description: Send mass email to list of recipients and ensure email send limits
     * @param template: classic email template Id
     * @param recipients: list of contact Ids
     **/
    private void sendMassEmail(String template, List<Id> recipients) {
        Messaging.reserveMassEmailCapacity(recipients.size());

        if(!recipients.isEmpty()) {
        	Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        	mail.setTargetObjectIds(recipients);
        	mail.setTemplateId(template);
        	Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
        }
    }
    
    global void finish(Database.BatchableContext BC)
    {
    }
}
