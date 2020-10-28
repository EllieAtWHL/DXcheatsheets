trigger convertlead on Lead (after update, after insert) {

    list<lead> mylead= trigger.new;
    for(lead l : mylead) {
        if(l.status=='Convert'&& !l.isConverted) {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setConvertedStatus('Converted To Customer');
            lc.setLeadId(l.id);
            lc.setDoNotCreateOpportunity(true);
            lc.setSendNotificationEmail(false);
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            System.debug(lcr.isSuccess());
        }
    }
}