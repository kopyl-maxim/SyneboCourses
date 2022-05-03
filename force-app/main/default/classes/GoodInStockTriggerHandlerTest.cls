@isTest
public with sharing class GoodInStockTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    ProductType__c pt = new ProductType__c(Name = 'test Name');
    insert pt;

    Goods_in_stock__c gis = new Goods_in_stock__c( Price__c = '2', Date__c = date.newinstance(2022, 2, 22), Name = 'Test Product', ProductNumber__c = '1', ProductType__c = pt.id, QuntityOfGoods__c = 'test');
    insert gis;

    Position__c posi = new Position__c(Name = 'test Position');
    insert posi;

    Employee__c empl = new Employee__c( Name = 'Test Employee',Position__c = posi.id );
    insert empl;
  }

  @isTest
  public static void goodInStockAfterInsertTest() {
    Employee__c empl = [SELECT id FROM Employee__c LIMIT 1];
    Goods_in_stock__c gis = [SELECT id FROM Goods_in_stock__c LIMIT 1];

    Test.startTest();

    Consignment_note__c cn1 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test1 ConsigmentNote' );
    Consignment_note__c cn2 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test2 ConsigmentNote' );
    Consignment_note__c cn3 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test3 ConsigmentNote' );
    insert new List<Consignment_note__c>{ cn1, cn2, cn3 };

    Test.stopTest();

    Goods_in_stock__c goodInStockTest = [SELECT id, Count_of_childs__c FROM Goods_in_stock__c LIMIT 1];

    System.assert(goodInStockTest.Count_of_childs__c == 3);
  }

  @isTest
  public static void goodInStockAfterUpdateTest() {
    Employee__c empl = [ SELECT id FROM Employee__c LIMIT 1 ];
    Goods_in_stock__c gis1 = [ SELECT id, ProductType__c FROM Goods_in_stock__c LIMIT 1 ];

    Goods_in_stock__c gis2 = new Goods_in_stock__c( Price__c = '2', Name = 'Test Prot', ProductNumber__c = '1', ProductType__c = gis1.ProductType__c, QuntityOfGoods__c = 'test2' );
    insert gis2;

    Test.startTest();

    Consignment_note__c cn1 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis1.id, Name = 'test1 ConsigmentNote' );
    Consignment_note__c cn2 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis1.id, Name = 'test2 ConsigmentNote' );
    Consignment_note__c cn3 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis1.id, Name = 'test3 ConsigmentNote' );

    List<Consignment_note__c> consNotList = new List<Consignment_note__c>();

    consNotList.add(cn1);
    consNotList.add(cn2);
    consNotList.add(cn3);

    insert consNotList;

    consNotList[0].Goods_in_stock__c = null;

    update consNotList[0];

    Test.stopTest();

    Goods_in_stock__c goodInStockTest = [ SELECT id, Count_of_childs__c FROM Goods_in_stock__c WHERE id = :gis1.id LIMIT 1 ];

    System.assertEquals(2, goodInStockTest.Count_of_childs__c);
  }

  @isTest
  public static void goodInStockBeforeUpdateTest() {
    Employee__c empl = [SELECT id FROM Employee__c LIMIT 1];
    Goods_in_stock__c gis = [ SELECT id, ProductType__c, Date__c FROM Goods_in_stock__c LIMIT 1 ];

    Test.startTest();

    Consignment_note__c consigNote = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test1 ConsigmentNote' );
    insert consigNote;

    date oldDate = gis.Date__c;

    consigNote.Name = 'test1';

    update consigNote;

    Test.stopTest();

    Goods_in_stock__c goodInStockTest = [ SELECT id, Date__c FROM Goods_in_stock__c LIMIT 1 ];

    System.assertNotEquals(oldDate, goodInStockTest.Date__c);
  }

  @isTest
  public static void goodInStockAfterDeleteTest() {
    Employee__c empl = [SELECT id FROM Employee__c LIMIT 1];
    Goods_in_stock__c gis = [ SELECT id, ProductType__c, Count_of_childs__c FROM Goods_in_stock__c LIMIT 1 ];

    Consignment_note__c cn1 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test1 ConsigmentNote' );
    insert cn1;

    Consignment_note__c cn2 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test2 ConsigmentNote' );
    insert cn2;

    Consignment_note__c cn3 = new Consignment_note__c( Employee__c = empl.id, Goods_in_stock__c = gis.id, Name = 'test3 ConsigmentNote' );
    insert cn3;

    Test.startTest();

    Database.DeleteResult result = Database.delete(cn1, false);

    Test.stopTest();

    Goods_in_stock__c goodInStockTest = [ SELECT id, Count_of_childs__c FROM Goods_in_stock__c LIMIT 1];

    System.assertEquals(2, goodInStockTest.Count_of_childs__c);
  }
}