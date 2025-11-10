import { NextResponse } from 'next/server'
import { verifyAuth } from '@/lib/auth'
import PrayerService from '@/services/PrayerService'

// GET - Fetch all prayers for the logged-in user
export async function GET(request) {
  try {
    const user = await verifyAuth(request)
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const filters = {
      user_id: user.id,
      status: searchParams.get('status'),
      limit: searchParams.get('limit'),
      offset: searchParams.get('offset')
    }

    const prayers = await PrayerService.getAll(filters)

    return NextResponse.json({ 
      success: true,
      prayers 
    })
  } catch (error) {
    console.error('Error fetching prayers:', error)
    return NextResponse.json({ 
      error: 'Failed to fetch prayers',
      message: error.message 
    }, { status: 500 })
  }
}

// POST - Create a new prayer
export async function POST(request) {
  try {
    const user = await verifyAuth(request)
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const newPrayer = await PrayerService.create(body, user.id)

    return NextResponse.json({ 
      success: true,
      prayer: newPrayer 
    }, { status: 201 })
  } catch (error) {
    console.error('Error creating prayer:', error)
    return NextResponse.json({ 
      error: 'Failed to create prayer',
      message: error.message 
    }, { status: 500 })
  }
}
