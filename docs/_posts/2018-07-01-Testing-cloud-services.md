---
layout: post
title:  "Testing Cloud Services - Book Notes"
date:   2018-07-01
categories: cloud, testing, automated
---

## Testing Cloud Services 

This book by Kees Blokland, Jeroen Mongerink and Martin Pol - How to test Saas, Paas & Iaas provides a great intro and quick overview of designing a test strategy for the cloud.

It begins with the <a href="https://www.nist.gov/programs-projects/nist-cloud-computing-program-nccp">National Institute of Standards and Technology</a> definitions of cloud computing.  For example describing the three service models:


* Software as a Service (SaaS)
* Platform as a Service (PaaS)
* Infrastructure as a Service (Iaas)
   
Details found <a href="https://csrc.nist.gov/publications/detail/sp/800-145/final">here</a>.

Using the <a href="https://en.wikipedia.org/wiki/V-Model_(software_development)">V-model</a> as a reference for the software development model the authors describe how cloud computing changes the testing landscape throughout the various phases of software development.

The book neatly segregates into the following sections:
  
 * Service Selection - how to chose providers and services in a complex landscape of vendors and services?
 * Performance - how do we measure if the service responds quickly enough?
 * Maintainability - costs of service management
 * Continuity - does the service meet business requirements?
 * Availability - what happens in case of failure?
    * Describes <a href="https://en.wikipedia.org/wiki/Failure_mode_and_effects_analysis">Failure-mode-and-effects</a> analysis as a useful technique in this area
 * Functionality - functional testing requirements 
    * Mentions <a href="https://www.youtube.com/watch?v=Lhyc5BSsLFs">Process Cycle Test</a> technique as a way to generate test test cases

This book quickly covers the above areas as a broad sweep of the challenges and benefits encountered when testing in the cloud. Each section as well provides a set of questions to be used as a great starting point for designing test strategies.
