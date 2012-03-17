<!---

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
<cfsilent>
	<cfset local.yesNoValueOptions = [{name=$.slatwall.rbKey('define.yes'), value=1},{name=$.slatwall.rbKey('define.no'), value=0}] />
	<cfset local.localeOptions = ['Chinese (China)','Chinese (Hong Kong)','Chinese (Taiwan)','Dutch (Belgian)','Dutch (Standard)','English (Australian)','English (Canadian)','English (New Zealand)','English (UK)','English (US)','French (Belgian)','French (Canadian)','French (Standard)','French (Swiss)','German (Austrian)','German (Standard)','German (Swiss)','Italian (Standard)',
									'Italian (Swiss)','Japanese','Korean','Norwegian (Bokmal)','Norwegian (Nynorsk)','Portuguese (Brazilian)','Portuguese (Standard)','Spanish (Mexican)','Spanish (Modern)','Spanish (Standard)','Swedish'] />
</cfsilent>

<cfoutput>
	<table class="table table-striped table-bordered">
		<tr>
			<th class="primary">#rc.$.Slatwall.rbKey('setting')#</th>
			<th>#rc.$.Slatwall.rbKey('setting.value')#</th>	
		</tr>
		<tr>
			<th class="primary">#rc.$.Slatwall.rbKey('setting')#</th>
			<th>#rc.$.Slatwall.rbKey('setting.value')#</th>	
		</tr>
		<cf_SlatwallPropertyDisplay property="settingValue" edit="#rc.edit#" displaytype="table" titleClass="varWidth" object="#rc.allSettings.order_orderPlacedEmailFrom#" title="#rc.$.Slatwall.rbKey('setting.order.orderPlacedEmailFrom')#" fieldName="order_orderPlacedEmailFrom">
		<cf_SlatwallPropertyDisplay property="settingValue" edit="#rc.edit#" displaytype="table" titleClass="varWidth" object="#rc.allSettings.order_orderPlacedEmailCC#" title="#rc.$.Slatwall.rbKey('setting.order.orderPlacedEmailCC')#" fieldName="order_orderPlacedEmailCC">
		<cf_SlatwallPropertyDisplay property="settingValue" edit="#rc.edit#" displaytype="table" titleClass="varWidth" object="#rc.allSettings.order_orderPlacedEmailBCC#" title="#rc.$.Slatwall.rbKey('setting.order.orderPlacedEmailBCC')#" fieldName="order_orderPlacedEmailBCC">
		<cf_SlatwallPropertyDisplay property="settingValue" edit="#rc.edit#" displaytype="table" titleClass="varWidth" object="#rc.allSettings.order_orderPlacedEmailSubject#" title="#rc.$.Slatwall.rbKey('setting.order.orderPlacedEmailSubject')#" fieldName="order_orderPlacedEmailSubject">
		<tr class="spdorder_orderNumberGeneration">
			<td class="title varWidth">#rc.$.Slatwall.rbKey('setting.order.orderNumberGeneration')#</td>
			<cfif rc.edit>
				<td id="spdorder_orderNumberGeneration" class="value">
					<select name="order_orderNumberGeneration">
						<option value="autoIncrement" <cfif rc.allSettings.order_orderNumberGeneration.getSettingValue() eq "autoIncrement">selected="selected"</cfif>>#$.slatwall.rbKey('define.autoIncrement')#</option>
						<cfloop array="#rc.customIntegrations#" index="local.customIntegration">
							<option value="#local.customIntegration.getIntegrationPackage()#" <cfif rc.allSettings.order_orderNumberGeneration.getSettingValue() eq local.customIntegration.getIntegrationPackage()>selected="selected"</cfif>>#local.customIntegration.getIntegrationName()#</option>	
						</cfloop>
						<!--- Loop over custom integrations --->
					</select>
				</td>
			<cfelse>
				<td id="spdorder_orderNumberGeneration" class="value">#rc.allSettings.order_orderNumberGeneration.getSettingValue()#</td>	
			</cfif>
		</tr>
	</table>
</cfoutput>