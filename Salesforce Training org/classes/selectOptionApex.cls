public class selectOptionApex {
    public List<selectOption> options {get; set;}
    
    public  selectOptionApex()
    {
        Selectoption option1 = new Selectoption('Chennai', 'chn');
        Selectoption option2 = new Selectoption('Hyderabad', 'Hyd');
        
        options =new  List<selectOption>();
        options.add(option1);
        options.add(option2);
        
    }

}