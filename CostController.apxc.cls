public class CostController {
    @AuraEnabled
    public static List<Cost__c> getCost(Id recordId) {
       	Contact c = [ Select Product__c, Home_Country__c From Contact Where Id = :recordId LIMIT 1];
		    String product = c.Product__c;
        String home_country = c.Home_Country__c;
		    List<Cost__c> cost = Database.query('SELECT Id,Name,Price1__c,Price2__c,Price3__c FROM Cost__c WHERE Product__c = :product AND Country__c = :home_country');
    	  return product;
    }
}
