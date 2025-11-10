import { NextResponse } from 'next/server'
import { query } from '@/lib/db'
import { verifyAuth } from '@/lib/auth'

// PUT - Update a prayer
export async function PUT(request, { params }) {
  try {
    const user = await verifyAuth(request)
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id } = params
    const body = await request.json()

    // Check if prayer belongs to user
    const existing = await query(
      'SELECT * FROM user_prayer_requests WHERE id = ? AND user_id = ?',
      [id, user.id]
    )

    if (existing.length === 0) {
      return NextResponse.json({ error: 'Prayer not found' }, { status: 404 })
    }

    // Build update query dynamically
    const updates = []
    const values = []

    if (body.title !== undefined) {
      updates.push('title = ?')
      values.push(body.title)
    }
    if (body.content !== undefined) {
      updates.push('content = ?')
      values.push(body.content)
    }
    if (body.category !== undefined) {
      updates.push('category = ?')
      values.push(body.category)
    }
    if (body.priority !== undefined) {
      updates.push('priority = ?')
      values.push(body.priority)
    }
    if (body.isPrivate !== undefined) {
      updates.push('is_private = ?')
      values.push(body.isPrivate ? 1 : 0)
    }
    if (body.status !== undefined) {
      updates.push('status = ?')
      values.push(body.status)
    }
    if (body.testimony !== undefined) {
      updates.push('testimony = ?')
      values.push(body.testimony)
      if (body.status === 'answered') {
        updates.push('answered_at = NOW()')
      }
    }

    values.push(id, user.id)

    await query(
      `UPDATE user_prayer_requests SET ${updates.join(', ')} WHERE id = ? AND user_id = ?`,
      values
    )

    const updated = await query(
      'SELECT * FROM user_prayer_requests WHERE id = ?',
      [id]
    )

    return NextResponse.json({ prayer: updated[0] })
  } catch (error) {
    console.error('Error updating prayer:', error)
    return NextResponse.json({ error: 'Failed to update prayer' }, { status: 500 })
  }
}

// DELETE - Delete a prayer
export async function DELETE(request, { params }) {
  try {
    const user = await verifyAuth(request)
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id } = params

    const result = await query(
      'DELETE FROM user_prayer_requests WHERE id = ? AND user_id = ?',
      [id, user.id]
    )

    if (result.affectedRows === 0) {
      return NextResponse.json({ error: 'Prayer not found' }, { status: 404 })
    }

    return NextResponse.json({ message: 'Prayer deleted successfully' })
  } catch (error) {
    console.error('Error deleting prayer:', error)
    return NextResponse.json({ error: 'Failed to delete prayer' }, { status: 500 })
  }
}
