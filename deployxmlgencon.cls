//ChamingaD
public with sharing class deployxmlgencon {
    
    public String debug {get; set;}
    public String deployContent {get; set;}
    
    public List<String> deployItems {get; set;}
    public List<String> deployClasses {get; set;}
    public List<String> deployPages {get; set;}
    public List<String> deployComponents {get; set;}
    public List<String> deployLayouts {get; set;}
    public List<String> deployObjects {get; set;}
    public List<String> deployResources {get; set;}
    public List<String> deployTriggers {get; set;}
    public List<String> deployWorkflows {get; set;}
    public List<String> deployApprovalProcess {get; set;}
    public List<String> deployEmailTemplates {get; set;}
    public String errorHighlights {get; set;}
    
    public deployxmlgencon(){
        
    }

    public void GenerateXML(){
        
    
        deployItems = new List<String>(); 
        deployClasses = new List<String>(); 
        deployPages= new List<String>(); 
        deployComponents = new List<String>(); 
        deployLayouts= new List<String>(); 
        deployObjects= new List<String>();
        deployResources= new List<String>();
        deployTriggers= new List<String>();
        deployWorkflows = new List<String>();
        deployApprovalProcess = new List<String>();
        deployEmailTemplates = new List<String>();
    
        Set<String> tempItems = new Set<String>();
        
        deployItems = deployContent.split('\n');
        tempItems.addAll(deployItems);
        deployItems.clear();
        deployItems.addAll(tempItems);
        errorHighlights = '';

        for (String item : deployItems){
            item = item.trim(); 
            String[] itemSplit = item.split('\\.');
            
            if (itemSplit !=null && itemSplit.size() > 1){
                if(itemSplit[1].trim()=='cls'){
                    deployClasses.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='page'){
                    deployPages.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='component'){
                    deployComponents.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='layout'){
                    deployLayouts.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='object'){
                    deployObjects.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='resource'){
                    deployResources.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='trigger'){
                    deployTriggers.add(itemSplit[0].trim());
                }else if (itemSplit[1].trim()=='workflow'){
                    deployWorkflows.add(itemSplit[0].trim());
                }else if (itemSplit.size() > 2 && itemSplit[2].trim()=='approvalProcess'){
                    deployApprovalProcess.add(itemSplit[0].trim()+'.'+itemSplit[1].trim());
                }else if (itemSplit[1].trim()=='email'){
                    deployEmailTemplates.add(itemSplit[0].trim());
                }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error: Invalid Input - ' + itemSplit[0].trim() + '.' + itemSplit[1].trim()));
                    
                    errorHighlights = errorHighlights + '\'' + item + '\\n\',';
                }
                

            }else if (String.valueof(itemSplit).trim().length() > 2){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error: Invalid Input - '+ String.valueOf(itemSplit)));
                
                errorHighlights = errorHighlights + '\'' +String.valueOf(itemSplit) + '\\n\',';
            }
        }
        
        CustomUtil.LogDebug('Generating with ANT XML GENERATOR ' 
                                + ' | Classes: '+deployClasses.size() 
                                + ' | Triggers: ' + deployTriggers.size() 
                                + ' | Pages: ' + deployPages.size()
                                + ' | Components: ' + deployComponents.size() 
                                + ' | Layouts: ' + deployLayouts.size()
                                + ' | Objects: ' + deployObjects.size()
                                + ' | Workflows: ' + deployWorkflows.size()
                                + ' | ApprovalProcess: ' + deployApprovalProcess.size()
                                + ' | Resources: ' + deployResources.size()
                                + ' | Emails : ' + deployEmailTemplates .size()
                                );

    }
  
}