﻿<!---

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

--->
<cfparam name="rc.edit" type="boolean">
<cfparam name="rc.location" type="any">

<ul id="navTask">
	<cf_SlatwallActionCaller action="admin:location.listLocations" type="list">
	<cfif !rc.edit>
		<cf_SlatwallActionCaller action="admin:location.editLocation" queryString="locationID=#rc.location.getLocationID()#" type="list">
	</cfif>
</ul>

<cfoutput>
	<div class="svoadminlocationdetail">
		<cfif rc.edit>
			
			#$.slatwall.getValidateThis().getValidationScript(theObject=rc.location, formName="LocationEdit")#
			
			<form name="LocationEdit" id="LocationEdit" action="#buildURL('admin:location.saveLocation')#" method="post">
				<input type="hidden" name="LocationID" value="#rc.Location.getLocationID()#" />
		</cfif>
		
		<dl class="twoColumn">
			<cf_SlatwallPropertyDisplay object="#rc.Location#" property="locationName" edit="#rc.edit#" first="true">
			
			<cfif not isNull(rc.location.getPrimaryAddress())>
				<input type="hidden" name="primaryAddress.LocationAddressID" value="#rc.location.getPrimaryAddress().getLocationAddressID()#" />
				<cf_SlatwallAddressDisplay address="#rc.location.getPrimaryAddress().getAddress()#" showName="false" showCompany="false" edit="#rc.edit#" fieldNamePrefix="primaryAddress.address."  />
				<!---<cf_SlatwallPropertyDisplay object="#rc.location.getPrimaryAddress()#" property="Address" fieldName="primaryAddress.Address" edit="#rc.edit#" valueLink="mailto:#rc.location.getAddress()#">--->
			<cfelse>
				<cfset newLocationAddress = $.slatwall.getService("addressService").newAddress() />
				<input type="hidden" name="primaryAddress.LocationAddressID" value="" />
				<cf_SlatwallAddressDisplay address="#newLocationAddress#" showName="false" showCompany="false" edit="#rc.edit#" fieldNamePrefix="primaryAddress.address."  />
				<!---<cf_SlatwallPropertyDisplay object="#newlocationEmail#" property="Address" fieldName="primaryAddress.Address" edit="#rc.edit#" valueLink="">--->
			</cfif>

			<!---<cf_SlatwallAddressDisplay address="#rc.locationAddress.getAddress()#" edit="#rc.edit#" fieldNamePrefix="locationAddresses[1].address." />--->
		</dl>
		
		<cfif rc.edit>
			<cf_SlatwallActionCaller action="admin:location.listlocations" type="link" class="button" text="#rc.$.Slatwall.rbKey('sitemanager.cancel')#">
			<cf_SlatwallActionCaller action="admin:location.savelocation" type="submit" class="button">
			</form>
		</cfif>
		
	</div>		
</cfoutput>
