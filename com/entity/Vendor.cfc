/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component displayname="Vendor" entityname="SlatwallVendor" table="SlatwallVendor" persistent="true" accessors="true" output="false" extends="BaseEntity" {
	
	// Persistent Properties
	property name="vendorID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="vendorName" ormtype="string";
	property name="vendorWebsite" ormtype="string";
	property name="accountNumber" ormtype="string";
	
	// Audit properties
	property name="createdDateTime" ormtype="timestamp";
	property name="createdByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="createdByAccountID";
	property name="modifiedDateTime" ormtype="timestamp";
	property name="modifiedByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="modifiedByAccountID";
	
	// Related Object Properties (many-to-one)
	property name="primaryEmailAddress" cfc="VendorEmailAddress" fieldtype="many-to-one" fkcolumn="primaryEmailAddressID";
	property name="primaryPhoneNumber" cfc="VendorPhoneNumber" fieldtype="many-to-one" fkcolumn="primaryPhoneNumberID";
	property name="primaryAddress" cfc="VendorAddress" fieldtype="many-to-one" fkcolumn="primaryAddressID";
	
	// Related Object Properties (one-to-many)
	property name="vendorOrders" singularname="vendorOrder" type="array" cfc="VendorOrder" fieldtype="one-to-many" fkcolumn="vendorID" cascade="save-update" inverse="true";
	property name="vendorAddresses" singularname="vendorAddress" type="array" cfc="VendorAddress" fieldtype="one-to-many" fkcolumn="vendorID" cascade="all-delete-orphan" inverse="true";
	property name="vendorPhoneNumbers" singularname="vendorPhoneNumber" type="array" cfc="VendorPhoneNumber" fieldtype="one-to-many" fkcolumn="vendorID" cascade="all" inverse="true";
	property name="vendorEmailAddresses" singularname="vendorEmailAddress" type="array" cfc="VendorEmailAddress" fieldtype="one-to-many" fkcolumn="vendorID" cascade="all" inverse="true";
	
	// Related Object Properties (many-to-many)
	property name="brands" singularname="brand" cfc="Brand" fieldtype="many-to-many" linktable="SlatwallVendorBrand" fkcolumn="vendorID" inversejoincolumn="brandID";
	//property name="products" singularname="product" cfc="Product" fieldtype="many-to-many" linktable="SlatwallVendorProduct" fkcolumn="vendorID" inversejoincolumn="productID";
	
	public Vendor function init(){
		// set default collections for association management methods
		if(isNull(variables.vendorAddresses)) {
			variables.vendorAddresses = [];
		}
		
		if(isNull(variables.vendorOrders)) {
		   variables.vendorOrders = [];
		}
	   
		if(isNull(variables.emailAddresses)) {
			variables.emailAddresses = [];
		}
		
		if(isNull(variables.brands)) {
			variables.brands = [];
		}

		return super.init();
	}
	
	public string function getPhoneNumber() {
		if(!isNull(getPrimaryPhoneNumber()) && !isNull(getPrimaryPhoneNumber().getPhoneNumber())) {
			return getPrimaryPhoneNumber().getPhoneNumber();
		}
		return "";
	}
	
	public string function getEmailAddress() {
		if(!isNull(getPrimaryEmailAddress()) && !isNull(getPrimaryEmailAddress().getEmailAddress())) {
			return getPrimaryEmailAddress().getEmailAddress();
		}
		return "";
	}
	
	public string function getAddress() {
		if(!isNull(getPrimaryAddress()) && !isNull(getPrimaryAddress().getAddress())) {
			return getPrimaryAddress().getAddress();
		} else {
			return getService("addressService").newAddress();
		}
	}
	
	// Function which verifies that the vendor can be deleted.
	public boolean function isDeletable() {
		return ArrayLen(getVendorOrders()) == 0;
	}
	
	/******* Association management methods for bidirectional relationships **************/
	
	// vendorAddresses (one-to-many)
	public void function addVendorAddress(required any vendorAddress) {
	   arguments.vendorAddress.setVendor(this);
	}
	
	public void function removeVendorAddress(required any vendorAddress) {
	   arguments.vendorAddress.removeVendor(this);
	}
	
	// vendorEmailAddresses (one-to-many)
	public void function addVendorEmailAddress(required any vendorEmailAddress) {
	   arguments.vendorEmailAddress.setVendor(this);
	}
	
	public void function removeVendorEmailAddress(required any vendorEmailAddress) {
	   arguments.vendorEmailAddress.removeVendor(this);
	}
	
	// vendorPhoneNumbers (one-to-many)
	public void function addVendorPhoneNumber(required any vendorPhoneNumber) {
	   arguments.vendorPhoneNumber.setVendor(this);
	}
	
	public void function removeVendorPhoneNumber(required any vendorPhoneNumber) {
	   arguments.vendorPhoneNumber.removeVendor(this);
	}
	
	/******* END: Association management methods for bidirectional relationships **************/
	
	// ============ START: Non-Persistent Property Methods =================
	
	// ============  END:  Non-Persistent Property Methods =================
		
	// ============= START: Bidirectional Helper Methods ===================
	
	// =============  END:  Bidirectional Helper Methods ===================
	
	// =================== START: ORM Event Hooks  =========================
	
	// ===================  END:  ORM Event Hooks  =========================
}