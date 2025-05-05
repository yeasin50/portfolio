# `user_info`

> contains initial and basic information such as name,title , social profile, experiences,education,certificates

### fields breakdown

- `version`

  - **Type**: Integer
  - **Description**: The version of the profile object.
  - **Example**: `0`

- `updated_at`

  - **Type**: String (ISO 8601 Date)
  - **Description**: The last updated date and time of the profile.
  - **Example**: `"2025-02-07T12:00:00Z"`

- `intro`

  - **Type**: Object
  - **Description**: Contains personal introduction details.
  - **Properties**:
    - `name`: The name of the individual.
    - `title`: The professional title or job role.
    - `short_title`: A shorter version of the title.
    - `description`: A short bio describing the individual's background or philosophy.
  - **Example**:
    ```json
    {
      "name": "Md.Yeasin Sheikh",
      "title": "Software Developer | Flutter specialist",
      "short_title": "Software Developer | Flutter",
      "description": "A limited lifespan who loves to solve problems and create values."
    }
    ```

- `connects`

  - **Type**: Array of Objects
  - **Description**: List of social and professional connections (links to platforms).
  - **Properties**:
    - `name`: The name of the platform (e.g., "github", "linkedin").
    - `logo`: URL to the platform's logo.
    - `url`: URL to the individual's profile on that platform.
    - `description` (Optional): Additional information about the connection.
    - `blur_hash`(Optional): Blur hash code .`U6Rp5w_4V[RPIT%MRj-;00tQ%MRk?bof%NIT`
    - `show`
      - **Type**: bool
      - **Description**: default is true, if false item will hide on app/client side
  - **Example**:
    ```json
    [
      {
        "name": "github",
        "logo": "https://raw.githubusercontent.com/yeasin50/yeasin50/refs/heads/master/assets/logo/github.png",
        "url": "https://github.com/yeasin50",
        "blur_hash": ":5Rfh2kA00xu-=xu%gxu-;ax%Nt7M{oft7WB00t7WVRj9ERj8_of%ft7ofRjxuWBMxozx]Rj9Foft7t7_4Rj?bofIURjofj[kCofa}fQD%of_4ay%MWB?bWARjozM{ofxuWB"
      },
      {
        "name": "stackOverflow",
        "logo": "https://raw.githubusercontent.com/yeasin50/yeasin50/refs/heads/master/assets/logo/stackoverflow.png",
        "url": "https://stackoverflow.com/users/10157127/md-yeasin-sheikh",
        "description": "Ranked #2 in August 2022 • Earned 7 gold badges for outstanding contributions, including Flutter & Dart."
      }
    ]
    ```

- `experience`

  - **Type**: Array of Objects
  - **Description**: A list of professional experiences and roles.
  - **Properties**:
    - `title`: The job title or role.
    - `organization`: An object containing the name of the organization.
    - `start`: Start date of the role.
    - `end`: End date of the role (if applicable).
    - `description`: A brief description of the role and responsibilities.
    - `show`
      - **Type**: bool
      - **Description**: default is true, if false item will hide on app/client side
  - **Example**:
    ```json
    [
      {
        "title": "Software Engineer",
        "organization": { "name": "Freelance" },
        "start": "2021-07-01T00:00:00Z",
        "end": null,
        "description": "Freelance hybrid developer with extensive experience in bringing creative ideas to life."
      }
    ]
    ```

- `education`

  - **Type**: Array of Objects
  - **Description**: A list of educational experiences.
  - **Properties**:
    - `school`: An object containing the name of the school.
    - `degree`: The degree earned.
    - `field`: The field of study.
    - `start`: Start date of the program.
    - `end`: End date of the program.
    - `grade`: Final grade or GPA.
    - `description`: A short description of the educational experience.
    - `images`: A list of images associated with the education (optional).
  - **Example**:
    ```json
    [
      {
        "school": { "name": "Daffodil International University" },
        "degree": "Bachelor",
        "field": "Computer Science and Engineering",
        "start": "2018-01-01T00:00:00Z",
        "end": "2023-09-01T00:00:00Z",
        "grade": "3.67 out of 4.0",
        "description": "Not that efficient for my limited lifespan",
        "images": []
      }
    ]
    ```

- `certificate`
  - **Type**: Array of Objects
  - **Description**: A list of certifications and completed courses.
  - **Properties**:
    - `name`: The name of the certification or course.
    - `organization`: An object containing the name of the organization issuing the certificate.
    - `credential_url`: The URL to the certificate (optional).
    - `image_url`: The URL to an image of the certificate (optional).
    - `issue_date`: The issue date of the certificate.
    - `expiration_date`: The expiration date of the certificate (if applicable).
    - `show`
      - **Type**: bool
      - **Description**: default is true, if false item will hide on app/client side
  - **Example**:
    ```json
    [
      {
        "name": "FlutterDevcamp State Management Special",
        "organization": { "name": "GDG London" },
        "credential_url": null,
        "image_url": null,
        "issue_date": "2023-09-01T00:00:00Z",
        "expiration_date": null
      }
    ]
    ```
