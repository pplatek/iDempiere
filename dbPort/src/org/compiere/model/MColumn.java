/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.*;
import java.util.*;
import org.compiere.util.*;

/**
 *	Persistent Column Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MColumn.java,v 1.6 2006/08/09 05:23:49 jjanke Exp $
 */
public class MColumn extends X_AD_Column
{
	/**
	 * 	Get MColumn from Cache
	 *	@param ctx context
	 * 	@param AD_Column_ID id
	 *	@return MColumn
	 */
	public static MColumn get (Properties ctx, int AD_Column_ID)
	{
		Integer key = new Integer (AD_Column_ID);
		MColumn retValue = (MColumn) s_cache.get (key);
		if (retValue != null)
			return retValue;
		retValue = new MColumn (ctx, AD_Column_ID, null);
		if (retValue.get_ID () != 0)
			s_cache.put (key, retValue);
		return retValue;
	}	//	get

	/**
	 * 	Get Column Name
	 *	@param ctx context
	 *	@param AD_Column_ID id
	 *	@return Column Name or null
	 */
	public static String getColumnName (Properties ctx, int AD_Column_ID)
	{
		MColumn col = MColumn.get(ctx, AD_Column_ID);
		if (col.get_ID() == 0)
			return null;
		return col.getColumnName();
	}	//	getColumnName
	
	/**	Cache						*/
	private static CCache<Integer,MColumn>	s_cache	= new CCache<Integer,MColumn>("AD_Column", 20);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Column_ID
	 *	@param trxName transaction
	 */
	public MColumn (Properties ctx, int AD_Column_ID, String trxName)
	{
		super (ctx, AD_Column_ID, trxName);
		if (AD_Column_ID == 0)
		{
		//	setAD_Element_ID (0);
		//	setAD_Reference_ID (0);
		//	setColumnName (null);
		//	setName (null);
		//	setEntityType (null);	// U
			setIsAlwaysUpdateable (false);	// N
			setIsEncrypted (false);
			setIsIdentifier (false);
			setIsKey (false);
			setIsMandatory (false);
			setIsParent (false);
			setIsSelectionColumn (false);
			setIsTranslated (false);
			setIsUpdateable (true);	// Y
			setVersion (Env.ZERO);
		}
	}	//	MColumn

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MColumn (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MColumn
	
	/**
	 * 	Parent Constructor
	 *	@param parent table
	 */
	public MColumn (MTable parent)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_Table_ID (parent.getAD_Table_ID());
		setEntityType(parent.getEntityType());
	}	//	MColumn
	
	
	/**
	 * 	Is Standard Column
	 *	@return true for AD_Client_ID, etc.
	 */
	public boolean isStandardColumn()
	{
		String columnName = getColumnName();
		if (columnName.equals("AD_Client_ID") 
			|| columnName.equals("AD_Org_ID")
			|| columnName.equals("IsActive")
			|| columnName.startsWith("Created")
			|| columnName.startsWith("Updated") )
			return true;
		
		return false;
	}	//	isStandardColumn
	
	/**
	 * 	Is Virtual Column
	 *	@return true if virtual column
	 */
	public boolean isVirtualColumn()
	{
		String s = getColumnSQL();
		return s != null && s.length() > 0;
	}	//	isVirtualColumn
	
	/**
	 * 	Is the Column Encrypted?
	 *	@return true if encrypted
	 */
	public boolean isEncrypted()
	{
		String s = getIsEncrypted();
		return "Y".equals(s);
	}	//	isEncrypted
	
	/**
	 * 	Set Encrypted
	 *	@param IsEncrypted encrypted
	 */
	public void setIsEncrypted (boolean IsEncrypted)
	{
		setIsEncrypted (IsEncrypted ? "Y" : "N");
	}	//	setIsEncrypted
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		int displayType = getAD_Reference_ID();
		if (DisplayType.isLOB(displayType))	//	LOBs are 0
		{
			if (getFieldLength() != 0)
				setFieldLength(0);
		}
		else if (getFieldLength() == 0) 
		{
			if (DisplayType.isID(displayType))
				setFieldLength(10);
			else if (DisplayType.isNumeric (displayType))
				setFieldLength(14);
			else if (DisplayType.isDate (displayType))
				setFieldLength(7);
			else
		{
			log.saveError("FillMandatory", Msg.getElement(getCtx(), "FieldLength"));
			return false;
		}
		}
		
		/** Views are not updateable
		UPDATE AD_Column c
		SET IsUpdateable='N', IsAlwaysUpdateable='N'
		WHERE AD_Table_ID IN (SELECT AD_Table_ID FROM AD_Table WHERE IsView='Y')
		**/
		
		//	Virtual Column
		if (isVirtualColumn())
		{
			if (isMandatory())
				setIsMandatory(false);
			if (isUpdateable())
				setIsUpdateable(false);
		}
		//	Updateable
		if (isParent() || isKey())
			setIsUpdateable(false);
		if (isAlwaysUpdateable() && !isUpdateable())
			setIsAlwaysUpdateable(false);
		//	Encrypted
		if (isEncrypted()) 
		{
			int dt = getAD_Reference_ID();
			if (isKey() || isParent() || isStandardColumn()
				|| isVirtualColumn() || isIdentifier() || isTranslated()
				|| DisplayType.isLookup(dt) || DisplayType.isLOB(dt)
				|| "DocumentNo".equalsIgnoreCase(getColumnName())
				|| "Value".equalsIgnoreCase(getColumnName())
				|| "Name".equalsIgnoreCase(getColumnName()))
			{
				log.warning("Encryption not sensible - " + getColumnName());
				setIsEncrypted(false);
			}
		}	
		
		//	Sync Terminology
		if ((newRecord || is_ValueChanged ("AD_Element_ID")) 
			&& getAD_Element_ID() != 0)
		{
			M_Element element = new M_Element (getCtx(), getAD_Element_ID (), get_TrxName());
			setColumnName (element.getColumnName());
			setName (element.getName());
			setDescription (element.getDescription());
			setHelp (element.getHelp());
		}
		return true;
	}	//	beforeSave

	
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		//	Update Fields
		if (!newRecord)
		{
			StringBuffer sql = new StringBuffer("UPDATE AD_Field SET Name=")
				.append(DB.TO_STRING(getName()))
				.append(", Description=").append(DB.TO_STRING(getDescription()))
				.append(", Help=").append(DB.TO_STRING(getHelp()))
				.append(" WHERE AD_Column_ID=").append(get_ID())
				.append(" AND IsCentrallyMaintained='Y'");
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			log.fine("afterSave - Fields updated #" + no);
		}
		return success;
	}	//	afterSave
	
	/**
	 * 	Get SQL Add command
	 *	@param table table
	 *	@return sql
	 */
	public String getSQLAdd (MTable table)
	{
		StringBuffer sql = new StringBuffer ("ALTER TABLE ")
			.append(table.getTableName())
			.append(" ADD ").append(getSQLDDL());
		String constraint = getConstraint(table.getTableName());
		if (constraint != null && constraint.length() > 0) {
			sql.append("; ").append("ALTER TABLE ")
			.append(table.getTableName())
			.append(" ADD ").append(constraint);
		}
		return sql.toString();
	}	//	getSQLAdd

	/**
	 * 	Get SQL DDL
	 *	@return columnName datataype ..
	 */
	public String getSQLDDL()
	{
		StringBuffer sql = new StringBuffer (getColumnName())
			.append(" ").append(getSQLDataType());
		//	Default
		if (getDefaultValue() != null && getDefaultValue().length() > 0)
		{
			sql.append(" DEFAULT ");
			// if (DisplayType.isText(getAD_Reference_ID()))
				// sql.append(DB.TO_STRING(getDefaultValue()));
			// else
				// sql.append(getDefaultValue());
			String defaultValue = getDefaultValue();
			if (defaultValue != null 
				&& defaultValue.length() > 0
				&& defaultValue.indexOf('@') == -1)		//	no variables
			{
				if (DisplayType.isText(getAD_Reference_ID()) 
					|| getAD_Reference_ID() == DisplayType.List
					|| getAD_Reference_ID() == DisplayType.YesNo)
				{
					if (!defaultValue.startsWith("'") && !defaultValue.endsWith("'"))
						defaultValue = DB.TO_STRING(defaultValue);
				}
			} else {
				defaultValue = " NULL ";
			}
			sql.append(defaultValue);
		}
		//	Inline Constraint
		if (getAD_Reference_ID() == DisplayType.YesNo)
			sql.append(" CHECK (").append(getColumnName()).append(" IN ('Y','N'))");

		//	Null
		if (isMandatory())
			sql.append(" NOT NULL");
		return sql.toString();
	}	//	getSQLDDL	
	
	/**
	 * 	Get SQL Modify command
	 *	@param table table
	 *	@param setNullOption generate null / not null statement
	 *	@return sql separated by ;
	 */
	public String getSQLModify (MTable table, boolean setNullOption)
	{
		StringBuffer sql = new StringBuffer();
		StringBuffer sqlBase = new StringBuffer ("ALTER TABLE ")
			.append(table.getTableName())
			.append(" MODIFY ").append(getColumnName());
		
		//	Default
		StringBuffer sqlDefault = new StringBuffer(sqlBase)
			.append(" ").append(getSQLDataType())
			.append(" DEFAULT ");
		String defaultValue = getDefaultValue();
		if (defaultValue != null 
			&& defaultValue.length() > 0
			&& defaultValue.indexOf('@') == -1)		//	no variables
		{
			if (DisplayType.isText(getAD_Reference_ID()) 
				|| getAD_Reference_ID() == DisplayType.List
				|| getAD_Reference_ID() == DisplayType.YesNo)
			{
				if (!defaultValue.startsWith("'") && !defaultValue.endsWith("'"))
					defaultValue = DB.TO_STRING(defaultValue);
			}
			sqlDefault.append(defaultValue);
		}
		else
		{
			sqlDefault.append(" NULL ");
			defaultValue = null;
		}
		sql.append(sqlDefault);
		
		//	Constraint

		//	Null Values
		if (isMandatory() && defaultValue != null && defaultValue.length() > 0)
		{
			StringBuffer sqlSet = new StringBuffer("UPDATE ")
				.append(table.getTableName())
				.append(" SET ").append(getColumnName())
				.append("=").append(defaultValue)
				.append(" WHERE ").append(getColumnName()).append(" IS NULL");
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append(sqlSet);
		}
		
		//	Null
		if (setNullOption)
		{
			StringBuffer sqlNull = new StringBuffer(sqlBase);
			if (isMandatory())
				sqlNull.append(" NOT NULL");
			else
				sqlNull.append(" NULL");
			sql.append(DB.SQLSTATEMENT_SEPARATOR).append(sqlNull);
		}
		//
		return sql.toString();
	}	//	getSQLModify

	/**
	 * 	Get SQL Data Type
	 *	@return e.g. NVARCHAR2(60)
	 */
	private String getSQLDataType()
	{
		int dt = getAD_Reference_ID();
		if (DisplayType.isID(dt) || dt == DisplayType.Integer)
			return "NUMBER(10)";
		if (DisplayType.isDate(dt))
			return "DATE";
		if (DisplayType.isNumeric(dt))
			return "NUMBER";
		if (dt == DisplayType.Binary)
			return "BLOB";
		if (dt == DisplayType.TextLong)
			return "CLOB";
		if (dt == DisplayType.YesNo)
			return "CHAR(1)";
		if (dt == DisplayType.List)
			return "NVARCHAR2(" + getFieldLength() + ")";
		else if (!DisplayType.isText(dt))
			log.severe("Unhandled Data Type = " + dt);
			
		return "NVARCHAR2(" + getFieldLength() + ")";
	}	//	getSQLDataType
	
	/**
	 * 	Get Table Constraint
	 *	@param tableName table name
	 *	@return table constraint
	 */
	public String getConstraint(String tableName)
	{
		if (isKey())
			return "CONSTRAINT " + tableName.substring(0, 26) + "_Key PRIMARY KEY (" + getColumnName() + ")";
		/**
		if (getAD_Reference_ID() == DisplayType.TableDir 
			|| getAD_Reference_ID() == DisplayType.Search)
			return "CONSTRAINT " ADTable_ADTableTrl
				+ " FOREIGN KEY (" + getColumnName() + ") REFERENCES "
				+ AD_Table(AD_Table_ID) ON DELETE CASCADE
		**/
		
		return "";
	}	//	getConstraint
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuffer sb = new StringBuffer ("MColumn[");
		sb.append (get_ID()).append ("-").append (getColumnName()).append ("]");
		return sb.toString ();
	}	//	toString
	
}	//	MColumn
