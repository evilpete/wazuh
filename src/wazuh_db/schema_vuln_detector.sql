/*
 * SQL SCHEMA FOR VULNERABILITY DETECTOR MODULE
 * COPYRIGHT (C) 2015-2019, WAZUH INC.
 * JANUARY 28, 2018.
 * THIS PROGRAM IS A FREE SOFTWARE, YOU CAN REDISTRIBUTE IT
 * AND/OR MODIFY IT UNDER THE TERMS OF GPLV2.
 */

BEGIN;

CREATE TABLE IF NOT EXISTS AGENTS (
         AGENT_ID INT NOT NULL,
         CPE_INDEX_ID INT DEFAULT 0,
         VENDOR TEXT NOT NULL,
         PACKAGE_NAME TEXT NOT NULL,
         VERSION TEXT NOT NULL,
         ARCH TEXT NOT NULL,
         PRIMARY KEY(AGENT_ID, VENDOR, PACKAGE_NAME, VERSION, ARCH)
);

 CREATE TABLE IF NOT EXISTS METADATA (
         TARGET TEXT PRIMARY KEY NOT NULL,
         PRODUCT_NAME TEXT NOT NULL,
         PRODUCT_VERSION TEXT,
         SCHEMA_VERSION TEXT,
         TIMESTAMP DATE NOT NULL
 );

 CREATE TABLE IF NOT EXISTS DB_METADATA (
         VERSION TEXT PRIMARY KEY NOT NULL
 );

 CREATE TABLE IF NOT EXISTS VULNERABILITIES_INFO (
         ID TEXT NOT NULL,
         TITLE TEXT,
         SEVERITY TEXT,
         PUBLISHED TEXT,
         UPDATED TEXT,
         REFERENCE TEXT,
         TARGET TEXT NOT NULL,
         RATIONALE TEXT,
         CVSS TEXT,
         CVSS_VECTOR TEXT,
         CVSS3 TEXT,
         BUGZILLA_REFERENCE TEXT,
         CWE TEXT,
         ADVISORIES TEXT,
         PRIMARY KEY(ID, TARGET)
 );

CREATE TABLE IF NOT EXISTS VULNERABILITIES (
        CVEID TEXT NOT NULL REFERENCES VULNERABILITIES_INFO(ID),
        TARGET TEXT NOT NULL REFERENCES VULNERABILITIES_INFO(V_OS),
        PACKAGE TEXT NOT NULL,
        PENDING BOOLEAN NOT NULL,
        OPERATION TEXT NOT NULL,
        OPERATION_VALUE TEXT,
        SECOND_OPERATION TEXT,
        SECOND_OPERATION_VALUE TEXT,
        PRIMARY KEY(CVEID, TARGET, PACKAGE, OPERATION_VALUE)
);

CREATE TABLE IF NOT EXISTS CPE_INDEX (
	ID INTEGER PRIMARY KEY AUTOINCREMENT,
    PART TEXT,
    VENDOR TEXT NOT NULL,
    PRODUCT TEXT NOT NULL,
    VERSION TEXT NOT NULL,
    UPDATEV TEXT,
    EDITION TEXT,
    LANGUAGE TEXT,
    SW_EDITION TEXT,
    TARGET_SW TEXT,
    TARGET_HW TEXT,
    OTHER TEXT
);

CREATE TABLE IF NOT EXISTS NVD_METADATA (
    YEAR INTEGER PRIMARY KEY,
    SIZE INTEGER,
    ZIP_SIZE INTEGER,
    GZ_SIZE INTEGER,
    SHA256 TEXT,
    LAST_MODIFIED INTEGER NOT NULL,
    CVES_NUMBER INTEGER
);


CREATE TABLE IF NOT EXISTS NVD_CVE (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NVD_METADATA_YEAR INTEGER,
    CVE_ID TEXT NOT NULL,
    CWE_ID TEXT,
    DESCRIPTION TEXT,
    PUBLISHED INTEGER,
    LAST_MODIFIED INTEGER
);

CREATE TABLE IF NOT EXISTS NVD_METRIC_CVSS (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NVD_CVE_ID INTEGER,
    VERSION TEXT,
    VECTOR_STRING TEXT,
    BASE_SCORE REAL,
    EXPLOITABILITY_SCORE REAL,
    IMPACT_SCORE REAL
);

CREATE TABLE IF NOT EXISTS NVD_REFERENCE (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NVD_CVE_ID INTEGER,
    URL TEXT,
    REF_SOURCE TEXT
);

CREATE TABLE IF NOT EXISTS NVD_CVE_CONFIGURATION (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NVD_CVE_ID INTEGER,
    PARENT INTEGER DEFAULT 0,
    OPERATOR TEXT
);

CREATE TABLE IF NOT EXISTS NVD_CVE_MATCH (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NVD_CVE_CONFIGURATION_ID INTEGER,
    ID_CPE INTEGER,
    VULNERABLE TEXT,
    URI TEXT,
    VERSION_START_INCLUDING TEXT,
    VERSION_START_EXCLUDING TEXT,
    VERSION_END_INCLUDING TEXT,
    VERSION_END_EXCLUDING TEXT
);

CREATE TABLE IF NOT EXISTS NVD_CPE (
    ID INTEGER,
    PART TEXT,
    VENDOR TEXT,
    PRODUCT TEXT,
    VERSION TEXT,
    UPDATED TEXT,
    EDITION TEXT,
    LANGUAGE TEXT,
    SW_EDITION TEXT,
    TARGET_SW TEXT,
    TARGET_HW TEXT,
    OTHER TEXT,
    PRIMARY KEY(PART, VENDOR, PRODUCT, VERSION, UPDATED, EDITION, LANGUAGE, SW_EDITION, TARGET_SW, TARGET_HW, OTHER)
);

CREATE TABLE IF NOT EXISTS CPE_HELPER (
    ID INTEGER PRIMARY KEY,
    TARGET TEXT,
    ACTION INT
);

CREATE TABLE IF NOT EXISTS CPE_HELPER_SOURCE (
    ID_HELPER INTEGER,
    CORRELATION_ID INTEGER,
    TYPE TEXT NOT NULL,
    TERM TEXT NOT NULL,
    PRIMARY KEY(ID_HELPER, TYPE, TERM)
);

CREATE TABLE IF NOT EXISTS CPE_HELPER_TRANSLATION (
    ID_HELPER INTEGER,
    CORRELATION_ID INTEGER,
    TYPE TEXT NOT NULL,
    TERM TEXT NOT NULL,
    PRIMARY KEY(ID_HELPER, TYPE, TERM)
);

CREATE TABLE IF NOT EXISTS MSB (
    CVEID TEXT,
    PRODUCT TEXT,
    PLATFORM TEXT,
    PATCH TEXT,
    PRIMARY KEY(CVEID, PRODUCT, PLATFORM, PATCH)
);

CREATE INDEX IF NOT EXISTS IN_CVE ON VULNERABILITIES_INFO (ID);
CREATE INDEX IF NOT EXISTS IN_PACK ON VULNERABILITIES (PACKAGE);
CREATE INDEX IF NOT EXISTS IN_OP ON VULNERABILITIES (OPERATION);
CREATE INDEX IF NOT EXISTS IN_CPE_ID ON CPE_INDEX (ID);
CREATE INDEX IF NOT EXISTS IN_CPE_VENDOR ON CPE_INDEX (VENDOR);
CREATE INDEX IF NOT EXISTS IN_CPE_PRODUCT ON CPE_INDEX (PRODUCT);
CREATE INDEX IF NOT EXISTS IN_CPE_VERSION ON CPE_INDEX (VERSION);
CREATE INDEX IF NOT EXISTS IN_NVD_CPE_ID ON NVD_CPE (ID);
CREATE INDEX IF NOT EXISTS IN_NVD_CPE_VENDOR ON NVD_CPE (VENDOR);
CREATE INDEX IF NOT EXISTS IN_NVD_CPE_PRODUCT ON NVD_CPE (PRODUCT);
CREATE INDEX IF NOT EXISTS IN_NVD_CPE_VERSION ON NVD_CPE (VERSION);
CREATE INDEX IF NOT EXISTS IN_NVD_CPE_SW_EDITION ON NVD_CPE (SW_EDITION);
CREATE INDEX IF NOT EXISTS IN_METADATA_LASTMOD ON NVD_METADATA (LAST_MODIFIED);
CREATE INDEX IF NOT EXISTS IN_METADATA_LASTMOD ON NVD_METADATA (YEAR);
CREATE INDEX IF NOT EXISTS IN_NVD_CVE_ID ON NVD_CVE (ID);
CREATE INDEX IF NOT EXISTS IN_CVSS_NVDCVE_ID ON NVD_METRIC_CVSS (NVD_CVE_ID);
CREATE INDEX IF NOT EXISTS IN_REF_NVDCVE_ID ON NVD_REFERENCE (NVD_CVE_ID);
CREATE INDEX IF NOT EXISTS IN_CONF_ID ON NVD_CVE_CONFIGURATION (ID);
CREATE INDEX IF NOT EXISTS IN_CONF_PARENT ON NVD_CVE_CONFIGURATION (PARENT);
CREATE INDEX IF NOT EXISTS IN_CONF_OPERATOR ON NVD_CVE_CONFIGURATION (OPERATOR);
CREATE INDEX IF NOT EXISTS IN_CONF_CVE_ID ON NVD_CVE_CONFIGURATION (NVD_CVE_ID);
CREATE INDEX IF NOT EXISTS IN_MATCH_ID ON NVD_CVE_MATCH (ID);
CREATE INDEX IF NOT EXISTS IN_MATCH_NVDCVE_ID ON NVD_CVE_MATCH (NVD_CVE_CONFIGURATION_ID);
CREATE INDEX IF NOT EXISTS IN_MATCH_ID_CPE ON NVD_CVE_MATCH (ID_CPE);
CREATE INDEX IF NOT EXISTS IN_MATCH_VULNERABLE ON NVD_CVE_MATCH (VULNERABLE);
CREATE INDEX IF NOT EXISTS IN_CPE_HELPER ON CPE_HELPER (ID);
CREATE INDEX IF NOT EXISTS IN_CPE_HELPER_ACTION ON CPE_HELPER (ACTION);
CREATE INDEX IF NOT EXISTS IN_CPE_SOURCE_ID ON CPE_HELPER_SOURCE (ID_HELPER);
CREATE INDEX IF NOT EXISTS IN_CPE_SOURCE_COR_ID ON CPE_HELPER_SOURCE (CORRELATION_ID);
CREATE INDEX IF NOT EXISTS IN_CPE_SOURCE_TYPE ON CPE_HELPER_SOURCE (TYPE);
CREATE INDEX IF NOT EXISTS IN_CPE_TRANSLATION_ID ON CPE_HELPER_TRANSLATION (ID_HELPER);
CREATE INDEX IF NOT EXISTS IN_CPE_TRANSLATION_COR_ID ON CPE_HELPER_TRANSLATION (CORRELATION_ID);
CREATE INDEX IF NOT EXISTS IN_CPE_TRANSLATION_TYPE ON CPE_HELPER_TRANSLATION (TYPE);
CREATE INDEX IF NOT EXISTS IN_MSB_CVEID ON MSB (CVEID);
CREATE INDEX IF NOT EXISTS IN_MSB_PRODUCT ON MSB (PRODUCT);
CREATE INDEX IF NOT EXISTS IN_MSB_PLATFORM ON MSB (PLATFORM);
CREATE INDEX IF NOT EXISTS IN_MSB_PATCH ON MSB (PATCH);

DELETE FROM DB_METADATA;

END;
