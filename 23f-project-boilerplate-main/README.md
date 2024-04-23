# UniGate - University Admissions Portal

UniGate is a comprehensive web application that revolutionizes the university admission process for applicants, high school counselors, and admissions staff. It provides a centralized platform designed to streamline the entire journey, from application submission to enrollment, ensuring a seamless and transparent experience for all stakeholders.

## Features

### For Applicants

- **Application Status Tracking**: Stay informed with real-time updates on your application status, including outstanding requirements or documents needed.
- **Personalized Admissions Checklist**: A tailored checklist guides you through the entire application process, ensuring you never miss a crucial step.
- **Decision Letter Access**: Securely view your admission decision letter directly within the portal.
- **Financial Aid and Scholarship Resources**: Explore a wealth of resources and information regarding financial aid opportunities and scholarship programs.
- **Event Calendar**: Never miss an important event with a comprehensive calendar featuring campus tours, information sessions, and deadlines.
- **Direct Communication with Admissions Officers**: A built-in messaging system allows you to contact admissions officers for inquiries or support.
- **Application Withdrawal**: Easily withdraw your application or express a change of interest with a few clicks.

### For Admitted Applicants

- **Acceptance/Decline Offer**: Seamlessly accept or decline your offer through the secure portal.
- **Online Deposit Payment**: Submit your enrollment deposit conveniently and securely within the portal.
- **Admitted Student Events**: Gain access to a curated list of events and activities designed specifically for admitted students.
- **Financial Aid Package Review**: Evaluate and compare financial aid packages offered by the university with ease.

### For Waitlisted Applicants

- **Continued Interest Form**: Express your ongoing interest in attending the university by submitting a continued interest form.
- **Continued Interest Essay**: Articulate your passion and commitment through a compelling continued interest essay.
- **Waitlist Decision Timeline**: Stay informed with transparent updates on the expected timeline for waitlist decisions.

### For Admissions Counselors

- **Applicant Profile Management**: Efficiently review and manage applicant information, documents, and application statuses from a centralized platform.
- **Waitlist Management**: Evaluate and process waitlisted applicants, including reviewing continued interest submissions, with streamlined workflows.
- **Committed Student Tracking**: Monitor the number of committed students and available spots for admission in real-time.
- **Communication Tools**: Leverage integrated tools to communicate with applicants and high school counselors, providing timely updates or requesting additional information.

### For High School Guidance Counselors

- **Student Application Tracking**: Monitor the application progress of your students and provide targeted guidance when needed.
- **Application Checklist Access**: Access comprehensive checklists of required documents and application milestones for each college your students are applying to.
- **Student Application History**: View a detailed history of all documents and forms submitted by your students to colleges.
- **Financial Aid and Scholarship Resources**: Access in-depth information about financial aid and scholarship options to better guide your students.
- **Cost of Attendance Estimates**: Obtain estimated cost of attendance for universities your students are interested in, facilitating better financial planning.

### Working and Implementation



**Part 1:-**
We started by creating a fork of the project and setup. We then created the database using MySql and filled it with mock data generated for different user personas with 50 columns of data for each entity and 10-15 entities in total. We created these tables ,generated the Mock data, exporting them in CSV files, and then proceeded to import the data to the created tables on datagrip. We also ran a few actions on the database to ensure it was working and the data was properly organized.

Part 2:- 
We created flask routes to implement the get, post, update and delete features of the REST API in our working model of it. Here, we created different blueprints for four different personas namely, applicant, application, events and guidance counselor. Taking inspiration from the blueprints of product and customer, I added the following features: Get an application, delete it if the applicant withdraws, update it with information, display upcoming events, delete them as the date passes and a few more. 
We then attempted to connect these flask routes to our implementation of the app on appsmith. However, we failed to do so due to a significant amount of technical errors arising from three people working on three different platforms and trying to coordinate everything. 



**Docker:- All three parts of our project are connected through docker and the instuctions to run it are in the docker compose file. The port for our project is as follows:     ports:
      - "8001:4000"

Video Link:- ** https://www.youtube.com

