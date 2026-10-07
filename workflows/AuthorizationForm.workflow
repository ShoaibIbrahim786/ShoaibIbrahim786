<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_position_owner_about_approval</fullName>
        <description>Email position owner about approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_position_person_about_approval</template>
    </alerts>
    <alerts>
        <fullName>Email_position_owner_about_rejection</fullName>
        <description>Email position owner about rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_position_person_about_approval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Status_to_Approved</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Approval Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_to_Pending</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Approval Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_to_Recalled</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Approval Status to Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Status_to_Rejected</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Approval Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Closed</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Status to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Open</fullName>
        <field>OwnerId</field>
        <lookupValue>shoaibibrahim07021993@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
