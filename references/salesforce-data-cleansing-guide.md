# Salesforce Data Cleansing Dashboard Guide

A comprehensive guide to building a dashboard that identifies duplicate records and missing data in Salesforce.

## Overview

This guide covers building a Salesforce Data Cleansing Dashboard using:
- **Salesforce Reports & Dashboards**
- **Salesforce Einstein Analytics** (optional)
- **Custom Apex Controllers** (for advanced logic)
- **Data.com** or **Duplicate Management** features

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Duplicate Record Detection](#duplicate-record-detection)
3. [Missing Data Detection](#missing-data-detection)
4. [Building the Dashboard](#building-the-dashboard)
5. [Automation](#automation)
6. [Maintenance](#maintenance)

---

## Prerequisites

### Required Permissions
- System Administrator profile
- Apex Developer permissions (if using custom code)
- Report & Dashboard creator permissions

### Enable Duplicate Management
1. Go to **Setup** → **Duplicate Management**
2. Enable **Duplicate Rules** and **Matching Rules**
3. Create matching rules for:
   - Accounts (Name, Website, Phone)
   - Contacts (Email, Phone, Name)
   - Leads (Email, Company, Phone)

---

## Duplicate Record Detection

### Method 1: Native Duplicate Rules

#### Create Matching Rule (Contacts)
```
Rule Name: Contact Email Match
Field: Email
Matching Method: Exact
```

#### Create Duplicate Rule
```
Rule Name: Contact Duplicate Rule
Alert Text: "This contact may be a duplicate."
Action: Block (optional)
```

### Method 2: Report-Based Detection

#### Create a "Duplicate Contacts" Report
1. **Report Type**: Contacts & Contacts
2. **Filters**:
   - Email = Not Null
3. **Group By**: Email
4. **Summary**: Count by Email

#### SOQL Query for Duplicates
```sql
SELECT Email, COUNT(Id) 
FROM Contact 
WHERE Email != null 
GROUP BY Email 
HAVING COUNT(Id) > 1
```

### Method 3: Custom Apex (Advanced)

```apex
public class DuplicateDetector {
    public static List<List<sObject>> findDuplicates(List<sObject> records) {
        return Database.findDuplicates(records);
    }
    
    public static Map<String, List<Contact>> getDuplicateContacts() {
        Map<String, List<Contact>> dupes = new Map<String, List<Contact>>();
        
        for (Contact c : [SELECT Id, Email, FirstName, LastName 
                          FROM Contact 
                          WHERE Email != null 
                          ORDER BY Email]) {
            if (dupes.containsKey(c.Email)) {
                dupes.get(c.Email).add(c);
            } else {
                dupes.put(c.Email, new List<Contact>{c});
            }
        }
        
        // Filter to only return emails with multiple contacts
        Map<String, List<Contact>> result = new Map<String, List<Contact>>();
        for (String email : dupes.keySet()) {
            if (dupes.get(email).size() > 1) {
                result.put(email, dupes.get(email));
            }
        }
        return result;
    }
}
```

---

## Missing Data Detection

### Common Missing Data Fields

| Object | Critical Fields |
|--------|-----------------|
| Contact | Email, Phone, Mailing Address |
| Lead | Email, Company, Phone |
| Account | Name, Phone, Billing Address |
| Opportunity | Close Date, Stage, Amount |

### Method 1: Report-Based

#### Create "Missing Email Contacts" Report
```
Report Type: Contacts
Filter: Email = null
```

#### Create "Missing Data" Summary Report
Group by: Account Name
Metrics: 
- Contacts with missing email
- Contacts with missing phone
- Contacts with incomplete addresses

### Method 2: Formula Fields

#### Contact Level Score
```apex
// Formula field on Contact
IF(ISBLANK(Email), 1, 0) + 
IF(ISBLANK(Phone), 1, 0) + 
IF(ISBLANK(MailingCity), 1, 0) + 
IF(ISBLANK(MailingState), 1, 0) +
IF(ISBLANK(MailingCountry), 1, 0)
```
Score > 0 = Missing data

### Method 3: Custom Apex Dashboard Controller

```apex
public class DataQualityDashboardController {
    
    public Integer getTotalContacts() {
        return [SELECT COUNT() FROM Contact];
    }
    
    public Integer getContactsWithEmail() {
        return [SELECT COUNT() FROM Contact WHERE Email != null];
    }
    
    public Integer getContactsWithPhone() {
        return [SELECT COUNT() FROM Contact WHERE Phone != null];
    }
    
    public Integer getDuplicateContacts() {
        Integer count = 0;
        for (AggregateResult ar : [SELECT Email, COUNT(Id) cnt 
                                   FROM Contact 
                                   WHERE Email != null 
                                   GROUP BY Email 
                                   HAVING COUNT(Id) > 1]) {
            count += (Integer)ar.get('cnt');
        }
        return count;
    }
    
    public List<Account> getAccountsWithMissingData() {
        return [SELECT Id, Name, Phone, BillingCity, BillingCountry 
                FROM Account 
                WHERE Phone = null 
                OR BillingCity = null 
                OR BillingCountry = null 
                LIMIT 100];
    }
}
```

---

## Building the Dashboard

### Dashboard Components

#### 1. Summary Cards (Top Row)
- **Total Contacts**: Count of all contacts
- **% Complete**: (With Email + Phone) / Total * 100
- **Duplicates Found**: Count of duplicate records
- **Records to Review**: Contacts missing critical data

#### 2. Data Completeness Chart (Bar Chart)
- X-Axis: Field Name
- Y-Axis: % Filled
  - Email
  - Phone
  - Mailing Address
  - Account Name

#### 3. Duplicate Records Table
- Columns: Record Name, Email, Created Date, Owner
- Action: Link to merge record page

#### 4. Missing Data by Account (Pie Chart)
- Segments: Account Name
- Values: Count of incomplete records

### Dashboard JSON (Lightning)

```json
{
  "title": "Data Cleansing Dashboard",
  "components": [
    {
      "title": "Data Quality Score",
      "type": "bar",
      "data": {
        "fields": ["Email", "Phone", "Address"],
        "values": [85, 72, 45]
      }
    },
    {
      "title": "Duplicate Records",
      "type": "table",
      "columns": ["Name", "Email", "Duplicate Of"]
    }
  ]
}
```

---

## Automation

### Schedule Data Quality Checks

```apex
// Schedule class
public class DataQualitySchedule implements Schedulable {
    public void execute(SchedulableContext SC) {
        DataQualityBatch b = new DataQualityBatch();
        Database.executeBatch(b);
    }
}
```

### Email Alerts

Create a **Flow** or **Apex Trigger** to:
1. Run daily
2. Check for new duplicates
3. Email report to data steward

### Flow: Daily Data Quality Check

1. **Trigger**: Scheduled (Daily 6:00 AM)
2. **Action 1**: Get Record Count (Contacts without email)
3. **Action 2**: Get Record Count (Duplicate contacts)
4. **Action 3**: Send Email to Admin with summary

---

## Maintenance

### Regular Tasks

| Frequency | Task |
|-----------|------|
| Daily | Review duplicate alerts |
| Weekly | Merge confirmed duplicates |
| Monthly | Data quality trend report |
| Quarterly | Update matching rules |

### Best Practices

1. **Prevention**: Use validation rules to block bad data entry
2. **Detection**: Run duplicate reports weekly
3. **Resolution**: Merge duplicates promptly
4. **Monitoring**: Track data quality trends over time

---

## Quick Start Checklist

- [ ] Enable Duplicate Management in Setup
- [ ] Create Matching Rules for key objects
- [ ] Create Duplicate Rules
- [ ] Build "Missing Data" reports
- [ ] Build "Duplicate Records" reports
- [ ] Create Dashboard with summary cards
- [ ] Set up daily/weekly email alerts
- [ ] Train users on data entry standards

---

## Related Salesforce Features

- **Salesforce Optimizer**: Built-in data analysis tool
- **Data.com**: Duplicate prevention & enrichment
- **Salesforce Shield**: Encryption & compliance
- **Einstein Activity Capture**: Data enrichment

---

*Last Updated: 2026-02-20*
