import { NextResponse } from 'next/server'
import { verifyAuth } from '@/lib/auth'
import { executeQuery } from '@/lib/db'

// Bible Study Registration API
export async function POST(request) {
  try {
    const user = await verifyAuth(request)
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { 
      session_id, 
      full_name, 
      email, 
      phone, 
      location_id, 
      year_of_study, 
      school, 
      registration_number, 
      notes 
    } = body

    // Validate required fields
    if (!session_id || !full_name || !email || !location_id || !year_of_study || !school) {
      return NextResponse.json({ 
        error: 'All required fields must be provided' 
      }, { status: 400 })
    }

    // Check if session exists and is open
    const [session] = await executeQuery(
      'SELECT * FROM bible_study_sessions WHERE id = ?',
      [session_id]
    )

    if (!session) {
      return NextResponse.json({ error: 'Session not found' }, { status: 404 })
    }

    if (!session.is_open) {
      return NextResponse.json({ 
        error: 'Registration is closed for this session' 
      }, { status: 400 })
    }

    // Check if deadline has passed
    if (new Date(session.registration_deadline) < new Date()) {
      return NextResponse.json({ 
        error: 'Registration deadline has passed' 
      }, { status: 400 })
    }

    // Check if user already registered for this session
    const [existing] = await executeQuery(
      'SELECT id FROM bible_study_registrations WHERE session_id = ? AND user_id = ?',
      [session_id, user.id]
    )

    if (existing) {
      return NextResponse.json({ 
        error: 'You are already registered for this session' 
      }, { status: 400 })
    }

    // Create registration
    const result = await executeQuery(
      `INSERT INTO bible_study_registrations 
       (session_id, user_id, full_name, email, phone, location_id, year_of_study, school, registration_number, notes, status) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')`,
      [
        session_id, 
        user.id, 
        full_name, 
        email, 
        phone || null, 
        location_id, 
        year_of_study, 
        school, 
        registration_number || null, 
        notes || null
      ]
    )

    // Get the created registration
    const [registration] = await executeQuery(
      `SELECT r.*, l.name as location_name, s.title as session_title
       FROM bible_study_registrations r
       LEFT JOIN study_locations l ON r.location_id = l.id
       LEFT JOIN bible_study_sessions s ON r.session_id = s.id
       WHERE r.id = ?`,
      [result.insertId]
    )

    return NextResponse.json({ 
      success: true, 
      message: 'Registration submitted successfully',
      data: registration 
    }, { status: 201 })
  } catch (error) {
    console.error('Error creating registration:', error)
    return NextResponse.json({ 
      error: 'Failed to submit registration',
      message: error.message 
    }, { status: 500 })
  }
}
