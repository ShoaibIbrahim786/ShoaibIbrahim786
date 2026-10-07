public with sharing class CreateContactController {
    
    @AuraEnabled
    public static String createContact(String firstName, String lastName, String email) {
        
        // Validate input on server side
        if (String.isBlank(firstName) || String.isBlank(lastName) || String.isBlank(email)) {
            throw new AuraHandledException('All fields are required.');
        }

        // Check for existing contact
        List<Contact> existingContacts = [
            SELECT Id, FirstName, LastName, Email 
            FROM Contact 
            WHERE FirstName = :firstName 
            AND LastName = :lastName 
            AND Email = :email 
            LIMIT 1
        ];

        if (!existingContacts.isEmpty()) {
            throw new AuraHandledException('Contact already exists.');
        }

        try {
            Contact con = new Contact();
            con.FirstName = firstName;
            con.LastName = lastName;
            con.Email = email;
            insert con;
            return 'Contact created successfully with Id: ' + con.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating contact: ' + e.getMessage());
        }
    }

}