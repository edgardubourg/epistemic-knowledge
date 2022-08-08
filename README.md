# epistemic-knowledge
1 README: This is a data dictionary and guide for the studies about Knowledge Expertise and its Evaluation

2 Data dictionary: 

Questions : 

1 What is the name of the first planet of the solar system? Mercury
2 What is the name of the first man that stepped on the Moon? Neil Armstrong
3 Which planet in the solar system is the only one that rotates clockwise? Venus 
4 Which planet has a hexagon shaped cloud formation on its north pole? Saturn
5 What is the orbital period of the Earth around the Sun in days? 365
6 What are the only two planets of our solar system that do not possess any moon? Mercury and Venus 
7 What is Earth’s only natural satellite? the Moon 
8 What is the only liveable planet of our solar system? Earth 
9 How old is the Sun (rounded up to the nearest billion years)? 5
10 What is the name of the first human object that crossed the limits of our solar system? Voyager 1
11What is the last planet of our solar system? Neptune 
12 What is the largest celestial object of the asteroid belt? Ceres
13 Pluto used to be the 9th planet of our solar system, but is no longer considered as a planet by scientists nowadays but as a …? Dwarf planet
14 Between which planets of our solar system is located the asteroid belt? Mars and Jupiter
15 What is the name of the circumstellar disc located beyond the orbit of Neptune? Kuiper belt 
16 When did Christopher Columbus discover the Americas? 1492
17 What is the date of the United States Declaration of Independence? 1776
18 What is the year of the beginning of the American Civil War? 1861
19 What is the year of the beginning of the Confederation Period? 1783
20 What is the date of foundation of the city of Los Angeles? 1781
21 When did the US declare war on Japan? 1941
22 Independence Day was first established as a holiday by Congress in what year? 1870
23 Who was the first President to live in the White House? John Adams
24 Where was the first Fourth of July Celebration with a firework display held? Boston
25 Which President was in office between 1893 and 1897? Grover Cleveland
26 When did Franklin D. Roosevelt die? 1945
27 Which was the first state to announce its secession from the Union before the Civil War began? South Carolina
28 When did prohibition start and end in the United States? 1920-1933
29 What is the name of the document with the first ten amendments to the Constitution that detail the protection of individual liberties? The Bill of Rights
30 What was called the first American Constitution? The Articles of Confederation
31 What is the name of Batman’s mother? Martha
32 What weapon does Thor use? Hammer
33 What is the real name of Spider-Man? Peter Parker
34 Who is the Human Torch to the Invisible Woman? Brother
35 Who created the character of Iron Man? Stan Lee
36 Batman protects which city? Gotham
37 Which superhero has a magic lasso and bullet-proof bracelets? Wonder Woman
38 The Green Lantern gains his power from which object? A ring
39 Wonder Woman comes from which island? Paradise Island
40 Which newspaper does Spiderman work for? The Daily Bugle
41 What is the name of the archnemesis of the Fantastic Four? Dr. Doom
42 What is the name of the archenemy of Aquaman? Malefic
43 Who killed Superman in the 1993 comic? Doomsday
44 Who was Aquaman’s sidekick? Aqualad
45 What is the family name of Alfred, Batman’s butler? Pennyworth

3 License: 
4 Citation: 
5 Machine readable meta data:
6 Raw data-dictionnary: 

raw_study1: the raw data from study 1 as extracted from Qualtrics

data_study1 : the raw data from study1 with useless rows removed and correctly named columns
Description of columns :  
 finished : 1 if the participant entirely completed the experiment, 0 otherwise
Q1’_First_Click : Time (in s) of the first click made by the participant on the qualtrics page of question 1(each trivia question is presented on one single page for the participant on qualtrics)
Q1’_Last_Click : Time (in s) of the last click made by the participant on the qualtrics page of question 1 (each trivia question is presented on one single page for the participant on qualtrics)
Q1’_Page_Submit : Time (in s) at which the qualtrics page of question 1 is submitted by the participant, no possibility to go backwards (each trivia question is presented on one single page for the participant on qualtrics)
Q1’_Click_Count : Number of clicks made by the participant on the page of question 1 (each trivia question is presented on one single page for the participant on qualtrics)
Q1: answer given by the participant to trivia question number 1
attention_check : the participant successfully passes the attention check if he writes « I pay attention »
id : Number attributed to each participant for anonymisation purposes

study1_coding_ed: the manual code of first coder
Description of columns : 
id : Number attributed to each participant for anonymisation purposes
question : question answered by the participant, identified by a number (eg Q31= What is the name of Batman’s mother?)
 answer : answer given by the participant to the question
time : Time (in s) at which the qualtrics page of question 1 is submitted by the participant, no possibility to go backwards (each trivia question is presented on one single page for the participant on qualtrics)
corr_ed : score given by coder 1 to the participant for his answer ; 2  is given when the participant answer « I don’t know », 1 when the answer is correct, 0 when it is incorrect


study1_coding_td: the manual code of second coder
Description of columns : 
id : Number attributed to each participant for anonymisation purposes
question : question answered by the participant, identified by a number (eg Q31= What is the name of Batman’s mother?)
answer : answer given by the participant to the question
time : Time (in s) at which the qualtrics page of question 1 is submitted by the participant, no possibility to go backwards (each trivia question is presented on one single page for the participant on qualtrics)
corr_td : score given by coder 2 to the participant for his answer ; 2  is given when the participant answer « I don’t know », 1 when the answer is correct, 0 when it is incorrect



raw_study2: the data from study 2 as extracted from Qualtrics

data_study2 : the raw data from study2 with useless rows removed and correctly named columns (except for questions numbers)
Description of columns : 
finished : 1 if the participant entirely completed the experiment, 0 otherwise
attention_check : the participant successfully passes the attention check if he writes « I pay attention »
Q31’_First_Click : Time (in s) of the first click made by the participant on the qualtrics page of question 1(each trivia question is presented on one single page for the participant on qualtrics)
Q31’_Last_Click : Time (in s) of the last click made by the participant on the qualtrics page of question 1 (each trivia question is presented on one single page for the participant on qualtrics)
Q31’_Page_Submit : Time (in s) at which the qualtrics page of question 1 is submitted by the participant, no possibility to go backwards (each trivia question is presented on one single page for the participant on qualtrics)
Q31’_Click_Count : Number of clicks made by the participant on the page of question 1 (each trivia question is presented on one single page for the participant on qualtrics)
Q231#1_1 : in this study, we asked real participants to guess which questions a virtual participant (vi) could also answer, knowing that the virtual participant correctly answer at least one question : « Q231 » qualifies the trivia question that the virtual participant answered successfully (and that the real participant is aware of) ; « #1_ 1 » qualifies a trivia question about which the real participant is asked to guess whether the virtual participant correctly answered or not ; 1 = according to the real participant,  vi answered correctly the question ; 2=   according to the real participant,  vi did not answer correctly the question
id : Number attributed to each participant for anonymisation purposes


7 Scripts: 
script_expertise_evaluation.R

8 Analysis ready data: Final data used in analysis

# STUDY 1 #

study1_final:
id: participant id
q: question
r: manually coded response
	0=false
	1=good
 
d.trivia : matrix used for nestedness calculus
id : participant id
Q1, etc : grade obtained at Q1 by the participant on the same row
	0 = false
	1 = good

study1_difficulty_solar_system : 
vi : question number 
difficulty1 : 1- the ratio of good answer/question in study 1 for trivia questions on the solar system theme

study1_difficulty_american_history : 
vi : question number 
difficulty1 : 1- the ratio of good answer/question in study 1 for trivia questions on the American history theme

study1_difficulty_super_heroes :
vi : question number 
difficulty1 : 1- the ratio of good answer/question in study 1 for trivia questions on the super heroes theme

study1_performance_participant_question_correct_solar_system : 
question :  question number
average_performance : mean performance(performance = mean of correct answers given by a participant on the trivia theme at hand) of the participants that got the given question right (solar system subset)

study1_performance_participant_question_correct_american_history :
question :  question number
average_performance : mean performance(performance = mean of correct answers given by a participant on the trivia theme at hand) of the participants that got the given question right (american history subset)

study1_performance_participant_question_correct_super_heroes : 
question :  question number
average_performance : mean performance(performance = mean of correct answers given by a participant on the trivia theme at hand) of the participants that got the given question right (super heroes subset)

#STUDY 2 # 
(this study only deals with the super heroes trivia set)

study2_all_vi_long : 
id : id of the real participant
vi : virtual participant’s id 
question : question about which the real participant is asked to juge if the virtual participant could correctly answer it
value : 1 : the virtual participant  can answer correctly the question according to the real participant
2 : the virtual participant cannot answer correctly the question according to the real participant


study2 _difficulty : 
vi : question
difficulty2 : inferred difficulty of the question as 1 – mean(number of inferred good answers at the question)  



study2_performance_vi: 
vi: question/virtual participant
perf_virtual: averaged performance score of a given vi, as the ratio of good answers they were reported to get right by the real participants

study2_performance_vi_participant :
id : real participant
vi: question/virtual participant
perf or inferred_perf: averaged performance score of a given vi according to a given real participant, as the ratio of good answers this vi was reported to get right according to this real participant



# Exploratory analysis - Study 2 #

study2_autoscore : 
id : id of the real participant
autoscore : number of questions that the real participant he would have gotten right 

full_accuracy : 
id : id of the real participant
accuracy_score: averaged accuracy of participants from study 2’s inferred score (the average of the absolute difference between the inferred performance and the actual performance, by participant)

full_overestimation :
id : id of the real participant
overestimation_score: averaged overestimation of participants from study 2’s inferred score (the average of the difference between the inferred performance and the actual performance, by participant)


