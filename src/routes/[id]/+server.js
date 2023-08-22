import { json } from '@sveltejs/kit';
import prisma from '$lib/prisma';

export async function PUT({ request, params }) {
	const { text } = await request.json();
	const todo = await prisma.todo.update({
		where: {
			id: params.id
		},
		data: {
			text
		}
	});
	return json(todo, { status: 201 });
}

export async function PATCH({ request, params }) {
	const todo_db = await prisma.todo.findUnique({
		where: {
			id: params.id
		}
	});
	const todo = await prisma.todo.update({
		where: {
			id: params.id
		},
		data: {
			done: !todo_db?.done
		}
	});
	return json(todo, { status: 201 });
}

export async function DELETE({ request, params }) {
	const todo = await prisma.todo.delete({
		where: {
			id: params.id
		}
	});
	return json(todo, { status: 201 });
}
