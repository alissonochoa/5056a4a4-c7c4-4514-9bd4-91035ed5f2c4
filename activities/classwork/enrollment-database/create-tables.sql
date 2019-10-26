-- Create student table
CREATE TABLE IF NOT EXISTS student (
    id UUID, -- es un tipo de ID aleatorio
    first_name TEXT,
    last_name TEXT,
    gender TEXT,
    gpa NUMERIC,
    age INT,
    PRIMARY KEY (id)  -- tiene que ser unica en la tabla
);

-- Create course table
CREATE TABLE IF NOT EXISTS course ( --n a 1 (muchos estudiantes pueden asistir a un curso)
    id UUID,
    name TEXT,
    department TEXT,
    level TEXT,
    study_mode TEXT,
    years INT,
    PRIMARY KEY (id)
);

-- Create enrollment table
CREATE TABLE IF NOT EXISTS enrollment (
    id UUID,
    student_id UUID REFERENCES student(id) ON DELETE CASCADE, --si hay otra relación, se borrará todo por eso se borra en cascada
    course_id UUID REFERENCES course(id) ON DELETE CASCADE,
    application_date DATE,
    approved INT,  -- son enteros pero se pueden usar boleanos
    PRIMARY KEY (id)
);
