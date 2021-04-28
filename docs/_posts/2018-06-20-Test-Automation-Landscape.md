---
layout: post
title:  "Aspects of a Test Automation Solution"
date:   2018-06-21
categories: graphviz
---

## Aspects of a Test Automation Solution

Aspects of test automation solution

* Product Knowledge
* Development Backlog

Graph below:
{% dot %}
    digraph architecture {
		node [shape=none]
        size="10,10!"
        rankdir=TB

        subgraph clusterKnowledge {
            label="Existing Product Knowledge"
		    SystemUnderTestKnowledge [label=<<TABLE style="rounded" border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">System-under-test (Knowledge)</TD></TR></TABLE>>];

        }

        subgraph clusterDevelopmentBacklog {
            label="New/Pending Product Knowledge"
		    DevelopmentBacklog [label=<<TABLE style="rounded" border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">Development Back log</TD></TR></TABLE>>];

        }

        subgraph clusterSystemUnderTest {  
            label="System-under-test"
		    SystemUnderTestWeb [label=<<TABLE border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">System-under-test (WEB)</TD></TR></TABLE>>];
		    SystemUnderTestApi [label=<<TABLE border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">System-under-test (API)</TD></TR></TABLE>>];
            subgraph clusterThirdParty {
                label="Third-party Components"
		        CoreDownstream [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">CoreDownstream</TD></TR></TABLE>>];
        		PartnerSystemA [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">PartnerSystemA</TD></TR></TABLE>>];
        		PartnerSystemB [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">PartnerSystemB</TD></TR></TABLE>>];
            }
        }


        subgraph clusterTestInfrastructure {  
            label="Development Infrastructure"
		    SourceCodeRepo [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">SourceCodeRepositor</TD></TR></TABLE>>];
		    CICDPipeLine [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">CICD-PipeLine</TD></TR></TABLE>>];
		    WebTestSuite [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">WebTestSuite</TD></TR></TABLE>>];
    		ApiTestSuite [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">ApiTestSuite</TD></TR></TABLE>>];
    		TestDataRepo [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">TestDataRepository</TD></TR></TABLE>>];
    		TestCaseRepo [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">TestCaseRepository</TD></TR></TABLE>>];
    		TestResultsRepo [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">TestResultsRepository(Auto)</TD></TR></TABLE>>];
    		TestResultsRepoManual [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">TestResultsRepository(Manual Tests)</TD></TR></TABLE>>];
    		TestIssueTracker [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">Issue-tracker</TD></TR></TABLE>>];
        }

        subgraph clusterProductionSupport {
            label="Production Support"
		    ProductionIssueTracker [label=<<TABLE border="2" cellspacing="5" cellpadding="5"><TR><TD border="0">ProductionIssueTracker</TD></TR></TABLE>>];
		    LogAggregator [label=<<TABLE border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">Log Aggregator</TD></TR></TABLE>>];
		    UptimeMonitor [label=<<TABLE border="2" cellspacing="5" cellpadding="5" ><TR><TD border="0">UptimeMonitor</TD></TR></TABLE>>];

        }

        DevelopmentBacklog -> TestCaseRepo
        SystemUnderTestKnowledge -> TestCaseRepo
        TestCaseRepo -> ApiTestSuite
        ApiTestSuite -> SystemUnderTestApi
        SystemUnderTestApi -> TestResultsRepo
        SystemUnderTestApi -> LogAggregator

    }

{% enddot %}

