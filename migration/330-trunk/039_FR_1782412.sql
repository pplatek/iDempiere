
CREATE TABLE AD_Document_Action_Access (

        AD_CLIENT_ID NUMBER(10,0) NOT NULL , 
     	AD_ORG_ID NUMBER(10,0) NOT NULL , 
     	ISACTIVE CHAR(1 BYTE) DEFAULT 'Y' NOT NULL , 
     	CREATED DATE DEFAULT SYSDATE NOT NULL , 
     	CREATEDBY NUMBER(10,0) NOT NULL , 
     	UPDATED DATE DEFAULT SYSDATE NOT NULL , 
     	UPDATEDBY NUMBER(10,0) NOT NULL , 
     	
     	C_DocType_ID NUMBER(10,0) NOT NULL,
   	AD_Role_ID NUMBER(10,0) NOT NULL,
   	AD_Ref_List_ID NUMBER(10,0) NOT NULL
  
);

COMMIT;

SET DEFINE OFF;
INSERT INTO AD_VAL_RULE(AD_VAL_RULE_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,TYPE,CODE,ENTITYTYPE)values(51002,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),100,to_date('2007-08-27','RRRR-MM-DD'),100,'AD_Ref_List_ID (Document Actions)','all document actions','S','AD_Ref_List.AD_Reference_ID=135','D');
INSERT INTO AD_TABLE(AD_TABLE_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,TABLENAME,ISVIEW,ACCESSLEVEL,ENTITYTYPE,AD_WINDOW_ID,AD_VAL_RULE_ID,LOADSEQ,ISSECURITYENABLED,ISDELETEABLE,ISHIGHVOLUME,IMPORTTABLE,ISCHANGELOG,REPLICATIONTYPE,PO_WINDOW_ID,COPYCOLUMNSFROMTABLE)values(53012,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),100,to_date('2007-08-27','RRRR-MM-DD'),100,'Document Action Access','Define access to document type / document action / role combinations.','Define access rules (add roles with access) for client/role/doctype/document action combinations. If no rules are defined for a client/doctype/doc action combination all roles can access the document action.','AD_Document_Action_Access','N','6','D',null,null,0,'N','Y','N','N','N','L',null,'N');
INSERT INTO AD_SEQUENCE(AD_SEQUENCE_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,VFORMAT,ISAUTOSEQUENCE,INCREMENTNO,STARTNO,CURRENTNEXT,CURRENTNEXTSYS,ISAUDITED,ISTABLEID,PREFIX,SUFFIX,STARTNEWYEAR)values(53011,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),100,to_date('2007-08-27','RRRR-MM-DD'),100,'AD_Document_Action_Access','Table AD_Document_Action_Access',null,'Y',1,1000000,1000001,50000,'N','Y',null,null,'N');

INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53222,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,'D','AD_Client_ID',53012,19,null,null,22,'@AD_Client_ID@','N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',102,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53223,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,'D','AD_Org_ID',53012,19,null,104,22,'@AD_Org_ID@','N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',113,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53224,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports. There are two reasons for de-activating and not deleting records: (1) The system requires the record for audit purposes. (2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,'D','IsActive',53012,20,null,null,1,null,'N','N','Y','Y',null,'N',null,'N','N',null,null,null,null,'N',348,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53225,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Created','Date this record was created','The Created field indicates the date that this record was created.',0,'D','Created',53012,16,null,null,7,null,'N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',245,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53226,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Created By','User who created this records','The Created By field indicates the user who created this record.',0,'D','CreatedBy',53012,18,110,null,22,null,'N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',246,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53227,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',0,'D','Updated',53012,16,null,null,7,null,'N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',607,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53228,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',0,'D','UpdatedBy',53012,18,110,null,22,null,'N','N','Y','N',null,'N',null,'N','N',null,null,null,null,'N',608,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53229,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',0,'D','C_DocType_ID',53012,19,null,null,22,null,'N','Y','Y','N',null,'N',null,'N','N',null,null,null,null,'N',196,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53230,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',0,'D','AD_Role_ID',53012,19,null,null,22,null,'N','Y','Y','N',null,'N',null,'N','N',null,null,null,null,'N',123,null,'N','N',null,null);
INSERT INTO AD_COLUMN(AD_COLUMN_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,UPDATED,CREATEDBY,UPDATEDBY,NAME,DESCRIPTION,HELP,VERSION,ENTITYTYPE,COLUMNNAME,AD_TABLE_ID,AD_REFERENCE_ID,AD_REFERENCE_VALUE_ID,AD_VAL_RULE_ID,FIELDLENGTH,DEFAULTVALUE,ISKEY,ISPARENT,ISMANDATORY,ISUPDATEABLE,READONLYLOGIC,ISIDENTIFIER,SEQNO,ISTRANSLATED,ISENCRYPTED,CALLOUT,VFORMAT,VALUEMIN,VALUEMAX,ISSELECTIONCOLUMN,AD_ELEMENT_ID,AD_PROCESS_ID,ISSYNCDATABASE,ISALWAYSUPDATEABLE,COLUMNSQL,MANDATORYLOGIC)values(53231,0,0,'Y',to_date('2007-08-27','RRRR-MM-DD'),to_date('2007-08-27','RRRR-MM-DD'),100,100,'Reference List','Reference List based on Table',null,0,'D','AD_Ref_List_ID',53012,19,null,51002,22,null,'N','Y','Y','N',null,'N',null,'N','N',null,null,null,null,'N',119,null,'N','N',null,null);

INSERT INTO AD_TAB(AD_TAB_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,AD_TABLE_ID,AD_WINDOW_ID,SEQNO,TABLEVEL,ISSINGLEROW,ISINFOTAB,ISTRANSLATIONTAB,ISREADONLY,AD_COLUMN_ID,HASTREE,WHERECLAUSE,ORDERBYCLAUSE,COMMITWARNING,AD_PROCESS_ID,PROCESSING,AD_IMAGE_ID,IMPORTFIELDS,AD_COLUMNSORTORDER_ID,AD_COLUMNSORTYESNO_ID,ISSORTTAB,ENTITYTYPE,INCLUDED_TAB_ID,READONLYLOGIC,DISPLAYLOGIC,ISINSERTRECORD,ISADVANCEDTAB)values(53013,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Document Action Access','Define access to document type / document action / role combinations.','Define access to document type / document action / role combinations.',53012,111,90,1,'N','N','N','N',53230,'N',null,null,null,null,'N',null,'N',null,null,'N','D',null,null,null,'Y','N');

INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53241,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports. There are two reasons for de-activating and not deleting records: (1) The system requires the record for audit purposes. (2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y',53013,53224,null,'Y',null,1,'N',50,null,'N','N','N','N','D',null,null,null);
INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53242,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y',53013,53222,null,'Y',null,22,'N',10,null,'N','N','N','N','D',null,null,null);
INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53244,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules','Y',53013,53229,null,'Y',null,22,'N',30,null,'N','N','N','N','D',null,null,null);
INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53245,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y',53013,53223,null,'Y',null,22,'N',20,null,'N','N','N','N','D',null,null,null);
INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53246,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Reference List','Reference List based on Table','The Reference List field indicates a list of reference values from a database tables.  Reference lists populate drop down list boxes in data entry screens','Y',53013,53231,null,'Y',null,22,'N',40,null,'N','N','N','N','D',null,null,null);
INSERT INTO AD_FIELD(AD_FIELD_ID,AD_CLIENT_ID,AD_ORG_ID,ISACTIVE,CREATED,CREATEDBY,UPDATED,UPDATEDBY,NAME,DESCRIPTION,HELP,ISCENTRALLYMAINTAINED,AD_TAB_ID,AD_COLUMN_ID,AD_FIELDGROUP_ID,ISDISPLAYED,DISPLAYLOGIC,DISPLAYLENGTH,ISREADONLY,SEQNO,SORTNO,ISSAMELINE,ISHEADING,ISFIELDONLY,ISENCRYPTED,ENTITYTYPE,OBSCURETYPE,AD_REFERENCE_ID,ISMANDATORY)values(53247,0,0,'Y',to_date('2007-08-29','RRRR-MM-DD'),100,to_date('2007-08-29','RRRR-MM-DD'),100,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Y',53013,53230,null,'N',null,22,'N',0,null,'N','N','N','N','D',null,null,null);


COMMIT;


UPDATE ad_sequence
   SET currentnextsys = (SELECT MAX (ad_column_id) + 1
                           FROM ad_column
                          WHERE ad_column_id < 1000000)
 WHERE NAME = 'AD_Column';

UPDATE ad_sequence
   SET currentnextsys = (SELECT MAX (ad_field_id) + 1
                           FROM ad_field
                          WHERE ad_field_id < 1000000)
 WHERE NAME = 'AD_Field';
 
 
 UPDATE ad_sequence
    SET currentnextsys = (SELECT MAX (ad_column_id) + 1
                            FROM ad_column
                           WHERE ad_column_id < 1000000)
  WHERE NAME = 'AD_Sequence';
 
 UPDATE ad_sequence
    SET currentnextsys = (SELECT MAX (ad_field_id) + 1
                            FROM ad_field
                           WHERE ad_field_id < 1000000)
  WHERE NAME = 'AD_Tab';
  
  UPDATE ad_sequence
     SET currentnextsys = (SELECT MAX (ad_message_id) + 1
                             FROM ad_message
                            WHERE ad_message_id < 1000000)
 WHERE NAME = 'AD_Table';
 
  UPDATE ad_sequence
     SET currentnextsys = (SELECT MAX (ad_element_id) + 1
                             FROM ad_element
                            WHERE ad_element_id < 1000000)
   WHERE NAME = 'AD_Window';
  
  UPDATE ad_sequence
     SET currentnextsys = (SELECT MAX (ad_column_id) + 1
                             FROM ad_column
                            WHERE ad_column_id < 1000000)
   WHERE NAME = 'AD_Val_Rule';
  
   
 COMMIT;
 
 delete from AD_Document_Action_Access;
 
 Insert into  AD_DOCUMENT_ACTION_ACCESS  ( 
 AD_CLIENT_ID , 
 AD_ORG_ID , 
 ISACTIVE , 
 CREATED , 
 CREATEDBY , 
 UPDATED , 
 UPDATEDBY , 
 C_DOCTYPE_ID , 
 AD_ROLE_ID , 
 AD_REF_LIST_ID 
 ) 
 
 (
 SELECT
 client.AD_Client_ID,
 0,
 'Y',
 SYSDATE,
 0,
 SYSDATE,
 0,
 doctype.C_DocType_ID,
 rol.AD_Role_ID,
 action.AD_Ref_List_ID
 FROM AD_Client client
 INNER JOIN C_DocType doctype ON (doctype.AD_Client_ID=client.AD_Client_ID)
 INNER JOIN AD_Ref_List action ON (action.AD_Reference_ID=135)
 INNER JOIN AD_Role rol ON (rol.AD_Client_ID=client.AD_Client_ID)
 );


COMMIT;