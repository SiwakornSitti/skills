import { NextRequest, NextResponse } from 'next/server';

interface RouteContext {
  params: { id: string };
}

export async function GET(
  request: NextRequest,
  { params }: RouteContext
) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const query = searchParams.get('query');
    
    // Your logic here
    const data = { id: params.id, query };

    return NextResponse.json({ success: true, data }, { status: 200 });
  } catch (error) {
    console.error('Error in GET /api/...:', error);
    return NextResponse.json(
      { success: false, error: 'Internal Server Error' },
      { status: 500 }
    );
  }
}

export async function POST(
  request: NextRequest,
  { params }: RouteContext
) {
  try {
    const body = await request.json();
    
    // Your logic here
    
    return NextResponse.json({ success: true, data: body }, { status: 201 });
  } catch (error) {
    console.error('Error in POST /api/...:', error);
    return NextResponse.json(
      { success: false, error: 'Internal Server Error' },
      { status: 500 }
    );
  }
}
