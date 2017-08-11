
class EventRow extends RowParent

	hasOwnRow: true
	segContainerEl: null # for EventRenderer
	segContainerHeight: null

	innerEl: null
	bgSegContainerEl: null # for EventRenderer. same el as innerEl :(


	constructor: ->
		super

		@eventRenderer = new TimelineGridEventRenderer(
			@view.timeGrid
			null # FillRenderer TODO!
			this # { segContainerEl, segContainerHeight }
		)


	renderEventContent: (tr) -> # TODO: rename to renderEventSkeleton
		tr.html('
			<td class="' + @view.widgetContentClass + '">
				<div>
					<div class="fc-event-container" />
				</div>
			</td>
		')
		@segContainerEl = tr.find('.fc-event-container')
		@innerEl = @bgSegContainerEl = tr.find('td > div')


# Watcher Garbage
# ---------------------------------------------------------------------------------------------------------------------

###
+ isInDom (why isn't already in DOM!?)
- hasResources / displayingResources (does not render it's own resourceS nor receive them)
###
EventRow::watchDisplayingEvents = ->
	@watch 'displayingEvents', [ # overrides previous 'displayingEvents' definition
		'isInDom'
		'hasEvents'
	], =>
		@requestRender('event', 'init', @executeEventsRender, [ @get('currentEvents') ])
	, =>
		@requestRender('event', 'destroy', @executeEventsUnrender)
