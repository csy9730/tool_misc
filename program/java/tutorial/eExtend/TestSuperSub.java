class BaseClass {
    private int n;
    BaseClass(){
      System.out.println("BaseClass()");
    }
    BaseClass(int n){
      System.out.println("BaseClass(int n)");
      this.n = n;
    }
}

class SubClass extends BaseClass{
  private int n;
  
  SubClass(){
    System.out.println("SubClass");
  }  
  
  public SubClass(int n){ 
    super(300);
    System.out.println("SubClass(int n):"+n);
    this.n = n;
  }
}

class SubClass2 extends BaseClass{
  private int n;
  
  SubClass2(){
    super(300); 
    System.out.println("SubClass2");
  }  
  
  public SubClass2(int n){
    System.out.println("SubClass2(int n):"+n);
    this.n = n;
  }
}
public class TestSuperSub{
  public static void main (String args[]){
      System.out.println("------SubClass extends ------");
      SubClass sc1 = new SubClass();
      SubClass sc2 = new SubClass(100); 
      System.out.println("------SubClass2 extends ------");
      SubClass2 sc3 = new SubClass2();
      SubClass2 sc4 = new SubClass2(200); 
    }
  }