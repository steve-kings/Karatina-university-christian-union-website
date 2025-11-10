import { NextResponse } from 'next/server'
import { verifyAuth } from '@/lib/auth'
import { executeQuery } from '@/lib/db'

// POST - Auto-assign groups based on location
export async function POST(request) {
  try {
    const user = await verifyAuth(request)
    if (!user || user.role !== 'admin') {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { session_id, location_id, members_per_group = 10 } = body

    if (!session_id) {
      return NextResponse.json({ error: 'Session ID is required' }, { status: 400 })
    }

    // Build query based on filters
    let query = `
      SELECT id FROM bible_study_registrations 
      WHERE session_id = ? AND status = 'approved'
    `
    const params = [session_id]

    if (location_id) {
      query += ' AND location_id = ?'
      params.push(location_id)
    }

    query += ' ORDER BY registered_at ASC'

    // Get all approved registrations
    const registrations = await executeQuery(query, params)

    if (registrations.length === 0) {
      return NextResponse.json({ 
        success: true, 
        message: 'No approved registrations to group',
        grouped: 0,
        total_groups: 0
      })
    }

    // Assign groups
    let groupNumber = 1
    let memberCount = 0

    for (const registration of registrations) {
      await executeQuery(
        'UPDATE bible_study_registrations SET group_number = ? WHERE id = ?',
        [groupNumber, registration.id]
      )

      memberCount++
      if (memberCount >= members_per_group) {
        groupNumber++
        memberCount = 0
      }
    }

    return NextResponse.json({ 
      success: true, 
      message: `Successfully grouped ${registrations.length} members into ${groupNumber} groups`,
      total_members: registrations.length,
      total_groups: groupNumber
    })
  } catch (error) {
    console.error('Error assigning groups:', error)
    return NextResponse.json({ 
      error: 'Failed to assign groups',
      message: error.message 
    }, { status: 500 })
  }
}
