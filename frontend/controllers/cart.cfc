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
component persistent="false" accessors="true" output="false" extends="BaseController" {

	property name="orderService" type="any";
	property name="productService" type="any";
	
	public void function clearItems(required struct rc) {
		getOrderService().clearOrderItems(order=rc.$.slatwall.cart());
		getFW().redirectExact(rc.$.createHREF(filename='/'));
	}
	
	public void function update(required struct rc) {
		getFW().setView("frontend:cart.detail");
	}
	
	public void function addItem(required struct rc) {
		param name="rc.productID" default="";
		param name="rc.selectedOptions" default="";
		param name="rc.quantity" default=1;
		param name="rc.orderShippingID" default="";
		
		// Get the product
		var product = getProductService().getByID(rc.productID);
		
		// Find the sku based on the product options selected
		var sku = product.getSkuBySelectedOptions(rc.selectedOptions);
		
		var cart = rc.$.slatwall.cart();
		
		// Check to see if the cart is a new order and save it if it is.
		rc.$.slatwall.session().setOrder(cart);

		// Add to the cart() order the new sku with quantity and shipping id
		getOrderService().addOrderItem(order=cart, sku=sku, quantity=rc.quantity, orderShippingID=rc.orderShippingID);
		
		// Save the Cart
		getOrderService().save(cart);
		
		getFW().redirectExact($.createHREF(filename='shopping-cart'), false);
	}
	
}