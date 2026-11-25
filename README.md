# CareLoop — Clinic No-Show Guard

## Project Overview
CareLoop is a data-driven clinic appointment no-show prediction and follow-up system developed for CareClick Clinics. It combines data cleaning, SQL analysis, machine learning risk prediction, and Generative AI analysis of patient follow-up notes to help clinics understand missed appointments and take preventive action.

## Problem Statement
Missed medical appointments waste clinic resources, disrupt schedules, and reduce access to healthcare. Identifying patients at risk of missing appointments and understanding the reasons behind missed visits can help clinics improve attendance and scheduling efficiency.

## Project Pipeline

### Part 1 — Data Ingestion & Cleaning
- Loaded and cleaned appointment data using Python and Pandas.
- Handled missing and invalid records.
- Generated cleaned datasets and rejected-row records.
- Enriched clinic data.

### Part 2 — SQL Analytics
- Loaded datasets into MySQL.
- Analyzed no-show rates across clinics.
- Studied lead-time buckets and monthly trends.
- Ranked clinics within cities.

### Part 3 — Machine Learning
- Built a Logistic Regression model to predict appointment no-show risk.
- Used cross-validation for model evaluation.
- Evaluated performance using ROC-AUC, precision, and recall.
- Generated risk scores and risk flags.

### Part 4 — Generative AI
- Used Gemini to analyze patient follow-up notes.
- Structured the results using Pydantic validation.
- Identified possible reasons for missed appointments.
- Generated summaries and recommended follow-up actions.
- Combined AI analysis with ML risk scores where matching predictions were available.

## Technologies Used
- Python
- Pandas
- SQL / MySQL
- Scikit-learn
- Google Gemini API
- Pydantic
- Google Colab
- Git & GitHub

## Project Outputs
- `appointments_clean.csv` — cleaned appointment dataset
- `clinics_enriched.csv` — enriched clinic data
- `rejected_rows.json` — records rejected during cleaning
- `notes_analysed.csv` — structured GenAI analysis of follow-up notes
- `test_risk_scores.csv` — ML model predictions on test data
- `final_recommendations.csv` — follow-up recommendations combined with available risk scores
- SQL scripts and Jupyter notebooks for the complete pipeline

## Machine Learning Evaluation
The Logistic Regression model was evaluated using 5-fold cross-validation.

- Mean ROC-AUC: 0.7993
- Standard deviation: 0.0524
- Selected classification threshold: 0.30

## GenAI Validation
The GenAI pipeline analyzed the first 10 follow-up notes:
- 9 non-empty notes successfully analyzed and validated.
- 1 blank note correctly skipped.
- Structured outputs include root cause, confidence, summary, and recommended action.

## How to Run
1. Open the notebooks in Google Colab.
2. Upload the required input CSV files when prompted.
3. Run notebook cells in sequence.
4. For the GenAI notebook, provide your own Gemini API key securely when prompted. Never upload your API key to GitHub.

## Disclaimer
This project is an academic prototype intended for demonstration and educational purposes. Model predictions and AI-generated explanations are not medical advice and should not be used as the sole basis for patient care decisions.
