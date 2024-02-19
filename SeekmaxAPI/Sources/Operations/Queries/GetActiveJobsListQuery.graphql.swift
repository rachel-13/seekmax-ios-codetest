// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetActiveJobsListQuery: GraphQLQuery {
  public static let operationName: String = "GetActiveJobsList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetActiveJobsList($limit: Int, $page: Int) { active(limit: $limit, page: $page) { __typename page size hasNext total jobs { __typename _id positionTitle description haveIApplied } } }"#
    ))

  public var limit: GraphQLNullable<Int>
  public var page: GraphQLNullable<Int>

  public init(
    limit: GraphQLNullable<Int>,
    page: GraphQLNullable<Int>
  ) {
    self.limit = limit
    self.page = page
  }

  public var __variables: Variables? { [
    "limit": limit,
    "page": page
  ] }

  public struct Data: SeekmaxAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("active", Active?.self, arguments: [
        "limit": .variable("limit"),
        "page": .variable("page")
      ]),
    ] }

    public var active: Active? { __data["active"] }

    /// Active
    ///
    /// Parent Type: `GetJobsResponse`
    public struct Active: SeekmaxAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.GetJobsResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("page", Int?.self),
        .field("size", Int?.self),
        .field("hasNext", Bool?.self),
        .field("total", Int?.self),
        .field("jobs", [Job?]?.self),
      ] }

      public var page: Int? { __data["page"] }
      public var size: Int? { __data["size"] }
      public var hasNext: Bool? { __data["hasNext"] }
      public var total: Int? { __data["total"] }
      public var jobs: [Job?]? { __data["jobs"] }

      /// Active.Job
      ///
      /// Parent Type: `Job`
      public struct Job: SeekmaxAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SeekmaxAPI.Objects.Job }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("_id", String?.self),
          .field("positionTitle", String?.self),
          .field("description", String?.self),
          .field("haveIApplied", Bool?.self),
        ] }

        public var _id: String? { __data["_id"] }
        public var positionTitle: String? { __data["positionTitle"] }
        public var description: String? { __data["description"] }
        public var haveIApplied: Bool? { __data["haveIApplied"] }
      }
    }
  }
}
