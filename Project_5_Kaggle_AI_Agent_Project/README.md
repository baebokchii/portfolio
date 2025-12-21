# Travel Concierge Multi-Agent System

*Fully Automated Travel Research + Itinerary Planning + Budget Estimation*
*Built for the Kaggle x Google 5-Day Agents Intensive Capstone Project*

## 🚀 Overview

This repository contains my capstone project for the AI Agents Intensive Course with Google & Kaggle.
The goal was to design and build a multi-agent travel concierge system capable of generating a full trip plan—research, itinerary, and budget—from a single user request.

Unlike typical “chatbot-style” travel agents, this system is fully modular, extensible, and follows the latest ADK (Agent Development Kit) best practices:

✔ Multi-Agent Architecture

✔ AgentTools (LLM-as-Tool chaining)

✔ Built-in Google Search Tool

✔ Built-in Code Executor (for real arithmetic budgeting)

✔ Stateful Execution via InMemorySessionService

✔ Clean Orchestration by a Coordinator Agent

This makes the agent practical, reliable, debuggable, and fully aligned with the course’s core learning objectives.


## 🧠 Why This Project? (Problem & Motivation)

Travel planning is time-consuming and fragmented:
	•	Research must be collected from multiple sources
	•	Itinerary suggestions vary wildly in quality
	•	Budget estimation requires extra work
	•	Large language models tend to hallucinate or be inconsistent
	•	Most “travel AIs” return only text — not structured and not reproducible

This system solves all of these problems by breaking tasks into specialized agents, each responsible for a well-defined output.


## 🎯 Solution Summary

The system provides, from a single prompt:
	1.	Destination Research Summary
	2.	Day-by-Day Itinerary (Morning / Afternoon / Evening)
	3.	Complete Budget Estimate with Python-based calculation

Everything is generated automatically, with no follow-up questions required.


## 🏗 System Architecture

┌─────────────────────────────────────────┐
│         TravelCoordinatorAgent          │
│     (Orchestrates entire workflow)      │
└───────────────┬───────────┬─────────────┘
                │           │
                │           │
     ┌──────────▼───┐   ┌───▼─────────────┐
     │ TravelResearch│   │ ItineraryPlanner│
     │    Agent      │   │      Agent      │
     └───────┬───────┘   └────────┬────────┘
             │                    │
             ▼                    ▼
       research_notes       itinerary_plan
             │                    │
             └──────────────┬─────┘
                            ▼
                    ┌──────────────┐
                    │  BudgetAgent │
                    └──────────────┘
                           │
                           ▼
                   budget_summary

## 🤖 Agents in Detail

1) TravelResearchAgent
	•	Uses Google Search Tool
	•	Synthesizes neighborhood and POI research
	•	Produces structured research notes in text form
	•	No JSON required → downstream planner uses the text directly

2) ItineraryPlannerAgent
	•	Reads both user request and research_notes
	•	Creates a realistic 3-day itinerary
	•	Morning / Afternoon / Evening blocks
	•	Minimal travel time, preference-aware scheduling

3) BudgetAgent
	•	Reads itinerary_plan
	•	NEVER performs mental math
	•	Always delegates calculations to the Built-In Code Executor
	•	Produces:
	•	Total estimated budget
	•	A full breakdown (food, transport, attractions, flights)
	•	List of assumptions

4) TravelCoordinatorAgent
	•	The “brain” of the system
	•	Calls the three agents in order
	•	Collects their outputs
	•	Produces a clean, human-friendly final summary



## ▶ How to Run the Project

1. Install dependencies
pip install -q google-genai google-adk nest_asyncio

2. Add your Gemini API Key
import os
os.environ["GOOGLE_API_KEY"] = "YOUR_KEY_HERE"

3. Run the full script

Simply execute:
python capstone_project_for_ai_agents_intensive_course.py

Or run it cell-by-cell in Google Colab.


## 🧪 Limitations & Future Improvements

Short-term additions
	•	Memory Bank to remember user preferences
	•	MCP Exchange Rate Tool for real currency calculations

Long-term improvements
	•	Parallel planning (reduce latency)
	•	Hotel search using OpenAPI tool
	•	Real map distance calculation via MCP server


## ⭐ Final Thoughts

This project represents a full application of the Agents Intensive Course concepts:
multi-agent design, tools, code execution, and stateful workflows.

It demonstrates how agents, when properly orchestrated, can solve complex problems more reliably than a single LLM prompt.

